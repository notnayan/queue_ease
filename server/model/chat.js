const mongoose = require("mongoose");
const db = require("../database/database_connection");

const chatSchema = new mongoose.Schema({
  users: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
  ],

  messages: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Message",
    },
  ],

  lastRead: [
    {
      user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
      message: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Message",
      },
      updatedAt: {
        type: Date,
        default: Date.now,
      },
    },
  ],

  updatedAt: {
    type: Date,
    default: Date.now,
  },

  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Chat = db.model("Chat", chatSchema);
module.exports = Chat;
