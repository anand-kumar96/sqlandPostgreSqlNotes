const express = require('express');
const postRoutes = require('./routes/postRoutes')
const app = express();

app.use(express.urlencoded({extended:true}));
app.use('/', postRoutes);

app.listen(3005,()=>{
    console.log("Server is listening at port 3005")
});


