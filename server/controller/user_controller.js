const UserService = require("../services/user_services");
const userModel = require("../model/user_models").userModel;
const userLoginModel = require("../model/user_models").userLoginModel;
const db = require("../database/database_connection");
const userService = new UserService(userModel, userLoginModel);
const upload = require("../services/profilehelper");
const secretKey = 'secretKey';
const jwt = require("jsonwebtoken");
const path = require('path');
const fs = require('fs');
const bcrypt = require("bcrypt");

exports.register = async (req, res) => {
  try {
    const { firstName, lastName, email, password, phoneNumber } = req.body;
    const successRes = await userService.registerUser(
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
    );
    res.json({ status: true, success: "User Registered Successfully !!!" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: false, error: "Failed to register user" });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await UserService.checkUser(email);
    if (!user) {
      throw new Error("User doesn't exist");
    }
    const isMatch = await user.comparePassword(password);
    if (!isMatch) {
      throw new Error("Invalid Password");
    }

    let tokenData = {
      _id: user._id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
    };

    const token = await UserService.generateToken(tokenData, "secretKey", "1h");

    res.status(200).json({ status: true, token: token, isAgent: user.isAgent });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: false, error: "Failed to login" });
  }
};

exports.becomeAgent = async (req, res) => {
  try {
    const { firstName, lastName, email, phoneNumber } = req.body;

    const user = await UserService.checkUser(email);
    if (!user) {
      throw new Error("User doesn't exist");
    }

    await UserService.changeToAgent(firstName, lastName, email, phoneNumber);

    res.status(200).json({ status: true, success: "User changed to agent" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: false, error: "Failed to login" });
  }
};

exports.uploadProfile = async (req, res) => {
  try {
    console.log("Upload profile function called");
    const token = req.headers.authorization.split(" ")[1];
    console.log("JWT token:", token);

    const decoded = jwt.verify(token, 'secretKey');
    console.log("Decoded token:", decoded);
    const userId = decoded._id; 
    console.log("User ID:", userId);

    const user = await userModel.findById(userId);
    console.log("User found:", user);
    if (!user) {
      console.log("User not found");
      return res.json("User not found");
    }

    user.profilePicture = req.file.filename;
    console.log("Updating profile picture for user:", user);
    const updatedUser = await userModel.findOneAndUpdate(
      { _id: userId },
      { $set: { profilePicture: user.profilePicture } },
      { new: true } 
    );

    if (updatedUser) {
      console.log("Profile picture uploaded successfully");
      return res.status(200).json({ message: "Profile picture uploaded successfully" });
    } else {
      console.log("Failed to upload profile picture");
      throw new Error("Failed to upload profile picture");
    }
  } catch (error) {
    console.error("Error uploading profile picture:", error);
    res.status(500).json({ error: "Internal server error" });
  }
}

exports.getProfilePicture = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];

    const decoded = jwt.verify(token, 'secretKey');
    const userId = decoded._id; 

    const user = await userModel.findById(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    if (!user.profilePicture) {
      return res.status(404).json({ error: "Profile picture not found" });
    }

    const imagePath = path.join(__dirname, '../uploads', user.profilePicture);
    
    const contentType = 'image/jpeg'; 

    fs.createReadStream(imagePath).pipe(res).on('error', (error) => {
      console.error("Error streaming profile picture:", error);
      res.status(500).json({ error: "Internal server error" });
    });

    res.setHeader('Content-Type', contentType);
  } catch (error) {
    console.error("Error getting profile picture:", error);
    res.status(500).json({ error: "Internal server error" });
  }
}

exports.deleteUser = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];

    const decoded = jwt.verify(token, 'secretKey');
    const userId = decoded._id; 

    const user = await userModel.findByIdAndDelete(userId);
    
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    res.status(200).json({ message: "User deleted successfully" });
  } catch (error) {
    console.error("Error deleting user:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

exports.updatePassword = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const { currentPassword, newPassword } = req.body;

    if (!currentPassword || !newPassword) {
      return res.status(400).json({ error: "Current password and new password are required" });
    }

    const decoded = jwt.verify(token, 'secretKey');
    const userId = decoded._id;

    const user = await userModel.findById(userId);
    
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const isMatch = await bcrypt.compare(currentPassword, user.password);
    if (!isMatch) {
      return res.status(400).json({ error: "Current password is incorrect" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedNewPassword = await bcrypt.hash(newPassword, salt);

    user.password = hashedNewPassword;
    await user.save();

    res.status(200).json({ message: "Password changed successfully" });
  } catch (error) {
    console.error("Error changing password:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

