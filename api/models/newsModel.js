const mongoose = require('mongoose');

const newSchema = mongoose.Schema({
    title: {
        type: String,
    },
    content: {
        type: String
    },
    imageUrl: {
        type:String
    },
    description: {
        type: String
    },
    category: {
        type: String,
    },
    createdAt: {
        type: Date,
    },
    source: {
        type: String
    }
})

const News = mongoose.model('News', newSchema)
module.exports = News