const router = require("express").Router();
const Request = require("../model/request");
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

router.post("/accept", async (req, res) => {
  try {
    const { requestId, agentId } = req.body;

    const request = await Request.findById(requestId);

    request.acceptedBy = agentId;
    request.status = "accepted";

    await request.save();

    const requester = Array.from(activeUsers).find(
      (user) => user.userId === request.requester
    );

    io.to(requester.socket.id).emit("requestAccepted", request);

    return res.status(200).json(request);
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

module.exports = router;
