const express = require("express");
const userRoutes = require("./routes/userRoutes");

module.exports = () => {
    const app = express();
    app.use(express.json());
    app.use('/', userRoutes);
    return app;
}