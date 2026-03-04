const express = require('express')
const route = express.Router()
const News = require('../models/newsModel')
const { message } = require('telegraf/filters')

route.get('/', async (req, res) => {
    const { page = 1, limit = 10, category, keyword } = req.query;

    const query = {};
    // Accept the (misspelled) `category` query param but map it to the
    // correct `category` field in the DB so filtering works as expected.
    if (category) query.category = category;
    if (keyword) query.title = { $regex: keyword, $options: 'i' };

    try {
        const pageNum = parseInt(page);
        const limitNum = parseInt(limit);

        const news = await News.find(query)
            .sort({ createdAt: -1 })
            .skip((pageNum - 1) * limitNum)
            .limit(limitNum);

        const total = await News.countDocuments(query);

        res.json({
            sucess: true,
            data: news,
            currentPage: pageNum,
            totalPagers: Math.ceil(total / limitNum),
        });
    } catch (error) {
        res.status(500).json({ succes: false, message: error.message });
    }
});
route.post('/post', async(req, res) => {
    const { title, description, imageUrl, content, category } = req.body

    try {
        const news = await News.create({ title, description, imageUrl, content, category })

        res.status(201).json({succes: true, data: news})
    } catch (error) {
        console.log(error)  
        res.status(500).json({
        succes: false,
        message: error.message
    })
    }
})
module.exports = route