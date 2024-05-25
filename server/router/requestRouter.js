const router = require("express").Router();
const Request = require("../model/request");
const Chat = require("../model/chat");
const { userModel } = require("../model/user_models");

// const { sendFcmMessagesConcurrently } = require("../utils/notifications_utils");
const { io, activeUsers } = require("../socket/index");

router.get("/", async (req, res) => {
  try {
    const requests = await Request.find({
      status: "pending",
      createdAt: { $gte: new Date(Date.now() - 60 * 60 * 1000) },
    })
      .populate("requester", "firstName lastName email phoneNumber")
      .sort({ createdAt: -1 });

    return res.status(200).json({ requests: requests });
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post("/", async (req, res) => {
  try {
    const { requesterId, destination, price } = req.body;

    const newRequest = new Request({
      requester: requesterId,
      destination,
      price,
    });

    await newRequest.save();

    const requester = await userModel
      .findById(requesterId)
      .select("firstName lastName email phoneNumber");

    const requesterSocket = new Request({
      _id: newRequest._id,
      requester,
      destination,
      price,
    });

    activeUsers.forEach((user) => {
      if (user["isAgent"] == true) {
        io.emit("newRequest", requesterSocket);
      }
    });

    res.status(200).json(requesterSocket);
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.get("/requests", async (req, res) => {
  try {
    const requests = await Request.find()
      .populate("requester", "firstName lastName email phoneNumber")
      .populate("acceptedBy", "firstName lastName email phoneNumber")
      .sort({ createdAt: -1 });

    return res.status(200).json({ requests: requests });
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post("/accept", async (req, res) => {
  try {
    const { requestId, agentId } = req.body;

    const request = await Request.findById(requestId);

    request.acceptedBy = agentId;
    request.status = "accepted";

    await request.save();

    const requester = Array.from(activeUsers).find(
      (user) => user.userId === request.requester._id.toString()
    );

    const acceptedBy = await userModel
      .findById(agentId)
      .select("firstName lastName email phoneNumber");

    const reqToSend = {
      _id: request._id,
      requester: request.requester,
      destination: request.destination,
      price: request.price,
      acceptedBy: acceptedBy,
      status: request.status,
      createdAt: request.createdAt,
    };

    io.to(requester.socket.id).emit("requestAccepted", reqToSend);

    return res.status(200).json(reqToSend);
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post("/isSearching", async (req, res) => {
  try {
    const userId = req.body.userId;

    const request = await Request.findOne({
      requester: userId,
      status: { $in: ["pending", "accepted"] },
      createdAt: { $gte: new Date(Date.now() - 60 * 60 * 1000) },
    });

    if (request) {
      return res.status(200).json({ isSearching: true });
    }

    return res.status(200).json({ isSearching: false });
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post("/cancel", async (req, res) => {
  try {
    const userId = req.body.userId;

    const request = await Request.findOne({
      requester: userId,
      status: { $in: ["pending", "accepted"] },
      createdAt: { $gte: new Date(Date.now() - 60 * 60 * 1000) },
    });

    if (request) {
      request.status = "cancelled";
      request.acceptedBy = null;
      await request.save();

      return res.status(200).json({ message: "Request cancelled" });
    }

    return res.status(200).json({ message: "No pending request found" });
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post("/isAccepted", async (req, res) => {
  try {
    const userId = req.body.userId;

    const request = await Request.findOne({
      requester: userId,
      status: { $in: ["accepted"] },
      createdAt: { $gte: new Date(Date.now() - 60 * 60 * 1000) },
    });

    if (request) {
      return res.status(200).json({ isSearching: true });
    }

    return res.status(200).json({ isSearching: false });
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post("/endChat", async (req, res) => {
  try {
    const userId = req.body.userId;

    const request = await Request.findOne({
      requester: userId,
      status: { $in: ["accepted"] },
    });

    if (request) {
      request.status = "completed";
      await request.save();

      activeUsers.forEach((user) => {
        if (user.id == request.acceptedBy) {
          io.emit("endRequest", { message: "Request completed" });
        }
      });

      return res.status(200).json({ message: "Request completed" });
    }

    return res.status(200).json({ message: "No pending request found" });
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

module.exports = router;
