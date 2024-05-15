const UserService = require("../services/user_services");
const userModel = require("../model/user_models").userModel;
const userLoginModel = require("../model/user_models").userLoginModel;

const userService = new UserService(userModel, userLoginModel);

exports.register = async (req, res, next) => {
    try {
        const { firstName, lastName, email, password, phoneNumber } = req.body;
        const successRes = await userService.registerUser(firstName, lastName, email, password, phoneNumber);
        res.json({ status: true, success: "User Registered Successfully !!!" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: false, error: "Failed to register user" });
    }
}

exports.login = async (req, res, next) => {
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
            phoneNumber: user.phoneNumber
          };

        const token = await UserService.generateToken(tokenData, "secretKey", "1h");

        res.status(200).json({ status: true, token: token });
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: false, error: "Failed to login" });
    }
}

