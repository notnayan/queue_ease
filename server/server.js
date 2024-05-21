const express = require("express");
const bodyParser = require("body-parser");
const dbConnection = require("./database/database_connection");
const userRouter = require("./router/user_router");
const requestRouter = require("./router/requestRouter");
const chatRouter = require("./router/chatRouter");

const PORT = process.env.PORT || 8000;
const app = express();

app.use(bodyParser.json());

const { io } = require("./socket/index");

app.use("/", userRouter);
app.use("/request", requestRouter);
app.use("/chat", chatRouter);

const server = app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at port ${PORT}`);
});

io.attach(server);
