const pool = require("../../pool");
pool.query(`
UPDATE posts
SET loc = POINT(lng,lat)
WHERE loc IS NULL 
`)
.then(()=>{
    console.log("Update completed");
    pool.end();
})
.catch((err)=>{
    console.log(err.message)
});

// here in this folder we are again writter config.env because pool.js looking for config.env in ./config.env so