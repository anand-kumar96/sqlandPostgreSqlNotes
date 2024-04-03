const UserRepo = require("../reopository/userRepository");

// get all users
exports.getAllUser = async(req,res) => {
    // Run a query to get all users
    const users = await UserRepo.find();
    
    // Send the Result back to the person who made the Request
    res.send(users);
}

// get user by id
exports.getUserById = async(req,res) => {
    const id = req.params.id;
    const user = await UserRepo.findById(id);
    if(user) {
        res.send(user);
    } else {
        res.sendStatus(404);
    }
}

// create user
exports.createUser = async(req,res) => {
    const{bio,username} = req.body;
    const user = await UserRepo.insert(bio,username)

    res.send(user);
}

// update user
exports.updateUser = async(req,res) => {
    const {id} = req.params;
    const{bio,username} = req.body;
    const user = await UserRepo.update(id,bio,username);
    
    if(user) {
        res.send(user);
    } else {
        res.sendStatus(404);
    }
}

//delete user
exports.deleteUser = async(req,res) => {
    const {id} = req.params;
    const user = await UserRepo.delete(id);

   if(user) {
    res.send(user);
    } else {
    res.sendStatus(404);
    }
}