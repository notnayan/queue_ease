const mongoose = require("mongoose");
const db = require("../database/database_connection");

const requestSchema = mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now,
  },

  requester: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },

  acceptedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },

  destination: {
    type: String,
    required: true,
  },

  price: {
    type: Number,
    required: true,
  },

  status: {
    type: String,
    required: true,
    enum: ["pending", "accepted", "expired", "completed", "cancelled"],
    default: "pending",
  },
});

const Request = db.model("Request", requestSchema);
module.exports = Request;
