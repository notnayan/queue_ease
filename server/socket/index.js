const { server } = require("../server");
const socket = require("socket.io");
const { userModel } = require("../model/user_models");

const io = socket(server);
const activeUsers = new Set();

io.on("error", (error) => {
  console.log(error);
});

io.on("connection", function (socket) {
  console.log("Socket connection established!");

  socket.on("joinRoom", async (userId) => {
    const existingUser = Array.from(activeUsers).find(
      (user) => user.userId === userId
    );
    if (!existingUser) {
      const user = await userModel.findById(userId);
      const isAgent = user.isAgent;

      activeUsers.add({
        userId,
        socket: socket,
        isAgent,
      });
    }

    const userIds = Array.from(activeUsers).map((user) => user.userId);
    socket.broadcast.emit("activeUsers", Array.from(userIds));
  });

  socket.on("disconnect", () => {
    activeUsers.delete(
      Array.from(activeUsers).find((user) => user.socket.id === socket.id)
    );

    const userIds = Array.from(activeUsers).map((user) => user.userId);

    socket.broadcast.emit("activeUsers", Array.from(userIds));
  });

  socket.on("message", (message) => {
    const { senderId, receiverId, messageBody } = message;
    if (activeUsers.has(receiverId)) {
      io.to(receiverId).emit("message", message);
    }
  });

  socket.on("getActiveUsers", () => {
    const userIds = Array.from(activeUsers).map((user) => user.userId);
    socket.emit("activeUsers", Array.from(userIds));
  });
});

module.exports = { io, activeUsers };
