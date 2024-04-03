const app = require("./src/app");
const dotenv = require('dotenv')
dotenv.config({path:"./config.env"})
const pool = require("./src/pool");

/// Connecting to database
pool.connect({
    host: process.env.HOST,
    port: process.env.PORT,
    database: process.env.DATABASE,
    user: process.env.USER,
    password: process.env.PASSWORD
})
  .then(() => {
      app().listen(3005,() => {
      console.log('Server is listening at port 3005')
      });
  })
  .catch((err) => {
      console.log(err.message);
  })