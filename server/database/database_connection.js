const mongoose = require("mongoose");

const DB =
  "mongodb+srv://nayan:nayan@cluster0.lgdxxqc.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

const connection = mongoose
  .createConnection(DB)
  .on("open", () => {
    console.log("MongoDB Connected !!!");
  })
  .on("error", () => {
    console.log("MongoDB Connection Error !!!");
  });

module.exports = connection;
