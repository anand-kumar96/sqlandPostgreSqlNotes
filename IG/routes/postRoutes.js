const express = require('express');
const { getAllPosts, createPost } = require('../controller/postController');

const router = express.Router();
router.get('/posts',getAllPosts);
router.post('/posts',createPost)

module.exports = router