const router = require("express").Router();
const User = require("../model/user_models");
const Chat = require("../model/chat");
const Message = require("../model/message");
// const { sendFcmMessagesConcurrently } = require("../utils/notifications_utils");
const { io, activeUsers } = require("../socket/index");

router.post("/send", async (req, res) => {
  try {
    const chat = await Chat.findById(req.body.chatId);
    const text = req.body.text;
    if (!chat) {
      return res.status(404).json({
        message: "Chat not found",
      });
    }
    if (!text) {
      return res.status(400).json({
        message: "Text is required",
      });
    }

    const message = new Message({
      text: text,
      sender: req.body.userId,
    });

    await message.save();
    chat.messages.push(message);
    chat.updatedAt = new Date();

    await chat.save();

    res.status(201).send({ message: "Message sent successfully", message });

    const receiverId = chat.users.find((id) => id != req.body.userId);
    const receiver = await User.findById(receiverId);

    const senderId = req.body.userId;
    const sender = await User.findById(senderId);

    io.emit(req.body.chatId, { message });

    const activeReceiver = Array.from(activeUsers).find((user) => {
      if (!user.userId) {
        return;
      }
      return user.userId.toString() === receiverId.toString();
    });

    if (activeReceiver) {
      activeReceiver.socket.emit("message", {
        chatId: req.body.chatId,
        message,
      });
    }

    // sendFcmMessagesConcurrently(
    //   receiver.deviceTokens,
    //   text,
    //   `${sender.firstName} ${sender.lastName} sent a message`
    // );
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.get("/", async (req, res) => {
  try {
    let { page, limit, q } = req.query;
    page = parseInt(page) || 1;
    limit = parseInt(limit) || 20;

    if (q) {
      const searchResult = [];

      const users = await User.find({
        $or: [
          { firstName: { $regex: q, $options: "i" } },
          { lastName: { $regex: q, $options: "i" } },
        ],
      })
        .select("firstName lastName phoneNumber")
        .skip((page - 1) * limit)
        .limit(limit)
        .where("_id")
        .ne(req.body.userId);

      await Promise.all(
        users.map(async (user) => {
          const chat = await Chat.findOne({
            users: { $all: [req.body.userId, user._id] },
          })
            .populate({
              path: "users",
              select: "firstName lastName",
              match: { _id: { $ne: req.body.userId } },
            })
            .populate({
              path: "messages",
              select: "text sender createdAt",
              options: { sort: { createdAt: -1 }, limit: 1 },
            });

          searchResult.push({ user, chat });
        })
      );

      searchResult.sort((a, b) => {
        if (!a.chat && b.chat) return 1;
        if (a.chat && !b.chat) return -1;
        return b.chat?.updatedAt - a.chat?.updatedAt;
      });

      const totalCount = await User.countDocuments({
        $or: [
          { firstName: { $regex: q, $options: "i" } },
          { lastName: { $regex: q, $options: "i" } },
        ],
      });

      const totalPages = Math.ceil(totalCount / limit);

      return res.status(200).json({
        searchResult,
        totalCount,
        totalPages,
        currentPage: page,
      });
    }

    const chats = await Chat.find({ users: req.body.userId })
      .sort({ updatedAt: -1 })
      .skip((page - 1) * limit)
      .limit(limit)
      .populate({
        path: "users",
        select: "firstName lastName",
        match: { _id: { $ne: req.body.userId } },
      })
      .populate({
        path: "messages",
        select: "text sender createdAt",
      });

    chats.forEach((chat) => {
      if (chat.messages.length > 0) {
        chat.messages = [chat.messages[chat.messages.length - 1]];
      }
    });

    const totalCount = await Chat.countDocuments({ users: req.body.userId });
    const totalPages = Math.ceil(chats.length / limit);

    res.status(200).json({
      chats,
      totalCount,
      totalPages,
      currentPage: page,
    });
  } catch (error) {
    res.status(500).send(error);
  }
});

router.post("/:id", async (req, res) => {
  try {
    const initiatorId = req.body.userId;
    const receiverId = req.params.id;

    const chats = await Chat.findOne({
      users: { $all: [initiatorId, receiverId] },
    })
      .populate({
        path: "users",
        select: "firstName lastName",
        match: { _id: { $ne: req.body.userId } },
      })
      .populate("messages")
      .sort({ updatedAt: -1 });

    if (!chats) {
      const chat = new Chat({
        users: [initiatorId, receiverId],
      });

      await chat.save();
      const chatToReturn = await Chat.findById(chat._id)
        .populate({
          path: "users",
          select: "firstName lastName",
          match: { _id: { $ne: req.body.userId } },
        })
        .populate("messages");

      return res
        .status(201)
        .send({ message: "New chat created", chats: chatToReturn });
    }

    res.status(200).send({ message: "Chat received successfully", chats });
    if (chats.messages.length > 0) {
      await readMessage(
        initiatorId,
        chats.messages[chats.messages.length - 1].id,
        chats.id
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(error);
  }
});

module.exports = router;
