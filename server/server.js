const express = require("express");
const bodyParser = require('body-parser');
const dbConnection = require("./database/database_connection");
const userRouter = require("./router/user_router");

const PORT = process.env.PORT || 8000;
const app = express();

app.use(bodyParser.json());

app.use('/', userRouter);

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});


