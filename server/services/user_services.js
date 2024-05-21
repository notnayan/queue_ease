const jwt = require("jsonwebtoken");
const { userModel, userLoginModel } = require("../model/user_models");

class UserService {
  constructor(userModel, userLoginModel) {
    this.userModel = userModel;
    this.userLoginModel = userLoginModel;
  }

  async registerUser(firstName, lastName, email, password, phoneNumber) {
    try {
      const createUser = new userModel({
        firstName,
        lastName,
        email,
        password,
        phoneNumber,
      });
      return await createUser.save();
    } catch (error) {
      throw error;
    }
  }

  async loginUser(email, password) {
    try {
      const loginUser = new userLoginModel({ email, password });
      return await loginUser.save();
    } catch (error) {
      throw error;
    }
  }

  static async checkUser(email) {
    try {
      return await userModel.findOne({ email });
    } catch (error) {
      throw new Error("Failed to check user: " + error.message);
    }
  }

  static async generateToken(tokenData, secretKey, jwt_expire) {
    return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
  }

  static async changeToAgent(firstName, lastName, email, phoneNumber) {
    try {
      return await userModel.findOneAndUpdate(
        { email },
        { firstName, lastName, email, phoneNumber, isAgent: true },
        { new: true }
      );
    } catch (error) {
      throw new Error("Failed to change to agent: " + error.message);
    }
  }
}

module.exports = UserService;
