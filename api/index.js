const express = require("express");
const connectDB = require("./services/db");
const bodyParser = require("body-parser");
const path = require("path");
const helmet = require("helmet");
const cors = require("cors");
const app = express();
require("dotenv").config();

// Connect Database
connectDB();

// Init Middleware
app.use(cors({}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Define Routes
app.use("/api/v1/users", require("./routes/user"));
app.use("/api/v1/image", require("./routes/image"));
app.use("/api/v1/admin", require("./routes/admin"));

// Serve static assets in production
if (process.env.NODE_ENV === "production") {
  // set static folder
  app.use(express.static("web/build"));

  app.get("*", (req, res) =>
    res.sendFile(path.resolve(__dirname, "web", "build", "index.html"))
  );
}
// app.use((req, res) => {
//   res.status(404).json({
//     success: false,
//     error: `Cannot ${req.method} ${req.url}`,
//   });
// });

const PORT = process.env.PORT || 5000;
app.listen(PORT, () =>
  console.log(`Server started on http://localhost:${PORT}`)
);
