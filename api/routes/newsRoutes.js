const express = require('express')
const route = express.Router()
const News = require('../models/newsModel')
const { message } = require('telegraf/filters')

route.get('/', async(req, res) => {
const {page = 1, limit = 10, catagory, keyword}= req.query
const query = {}
if(catagory) query.catagory
if(keyword) query.title = {$regex: keyword, $options: 'i'}

try {
    const news = await News.find(query)
                     .sort({createdAt: -1})
                     .skip((page - 1)*limit)
                     .limit(parseInt(limit))
    const total = await News.countDocuments(query)

    res.json({
        sucess: true,
        data: news,
        currentPage: parseInt(page),
        totalPagers: Math.ceil(total/limit),
    })
} catch (error) {
    res.status(500).json({
        succes: false,
        message: error.message
    })
}
})
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