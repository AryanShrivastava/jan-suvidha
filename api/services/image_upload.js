const multer = require("multer");

var storage = multer.diskStorage({
  destination: function (_req, _file, cb) {
    cb(null, "./uploads");
  },
  filename: function (_req, file, cb) {
    cb(null, file.originalname.replace(/\s/g, ""));
  },
});

const upload = multer({
  storage: storage,
  limits: { fileSize: 10000000000 },
});

module.exports = { upload };
