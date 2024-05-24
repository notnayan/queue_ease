const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("path");
const cloudinary = require("cloudinary").v2;

cloudinary.config({
  cloud_name: "dvynwrqpe",
  api_key: "191528866241673",
  api_secret: "WNWZmR5nzbG-hxx2ncC0iu4Ah24",
});

const storage = multer.diskStorage({
  destination: "./upload/profileImage",
  filename: (req, file, cb) => {
    return cb(
      null,
      `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`
    );
  },
});
const upload = multer({
  storage: storage,
});

router.post("/uploadImage", (req, res) => {
  upload.single("image")(req, res, async function (err) {
    if (err instanceof multer.MulterError) {
      return res.status(400).json({ msg: "Error uploading file" });
    } else if (err) {
      console.log(err);
      return res.status(500).json({ msg: "Internal Server Error" });
    }

    if (!req.file) {
      return res.status(400).json({ msg: "No file uploaded" });
    }

    const filePath = path.join("./upload/profileImage", req.file.filename);

    const cloudinaryResult = await cloudinary.uploader
      .upload(filePath, {
        public_id: `Image/${req.file.filename}`,
      })
      .catch((error) => {
        console.log(error);
        console.error(error.message);
        return res
          .status(500)
          .json({ msg: "Internal Server Error", error: error.message });
      });

    res.status(200).json({
      msg: "Upload successfully",
      imageUrl: cloudinaryResult.secure_url,
    });
  });
});

module.exports = router;
