const { text } = require("express");
const mongoose = require("mongoose");
const db = require("../database/database_connection");

const messageSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now,
  },

  text: {
    type: String,
    required: true,
  },

  sender: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
});

const Message = db.model("Message", messageSchema);
module.exports = Message;
