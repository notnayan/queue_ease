const router = require("express").Router();
const User = require("../model/user_models");
const Chat = require("../model/chat");
const Message = require("../model/message");
const Request = require("../model/request");
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

    const senderId = req.body.userId;

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

router.post("/", async (req, res) => {
  try {
    const initiatorId = req.body.userId;

    const request = await Request.findOne({
      $or: [{ requester: initiatorId }, { acceptedBy: initiatorId }],
      status: "accepted",
    });

    if (!request) {
      return res.status(404).json({
        message: "No accepted request found",
      });
    }

    const chats = await Chat.findOne({
      requestId: request._id,
    })
      .populate({
        path: "users",
        select: "firstName lastName phoneNumber",
        match: { _id: { $ne: req.body.userId } },
      })
      .populate("messages")
      .sort({ updatedAt: -1 });

    if (!chats) {
      const chat = new Chat({
        requestId: request._id,
        users: [request.requester, request.acceptedBy],
      });

      await chat.save();
      const chatToReturn = await Chat.findById(chat._id)
        .populate({
          path: "users",
          select: "firstName lastName phoneNumber",
          match: { _id: { $ne: req.body.userId } },
        })
        .populate("messages");

      return res
        .status(201)
        .send({ message: "New chat created", chats: chatToReturn, request });
    }

    res
      .status(200)
      .send({ message: "Chat received successfully", chats, request });
  } catch (error) {
    console.log(error);
    res.status(500).send(error);
  }
});

module.exports = router;
