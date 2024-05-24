const router = require("express").Router();
const userController = require("../controller/user_controller");
const upload = require("../services/profilehelper");

router.post("/registration", userController.register);
router.post("/login", userController.login);
router.post("/agent", userController.becomeAgent);
router.post('/upload-profile', upload.single('profilePicture'), userController.uploadProfile);
router.get('/profile-picture', userController.getProfilePicture);
router.delete('/delete-user', userController.deleteUser);
router.patch('/change-password', userController.updatePassword);

module.exports = router;
