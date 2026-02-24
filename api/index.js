const express = require('express')
const connectDb = require('./config/db')
const route = require('./routes/newsRoutes')
const bodyParser = require('body-parser')
require('dotenv').express
const app = express()
connectDb()
app.use(bodyParser.json())
app.use('/api/news', route)

const catagories = [
{name: 'All', icon: 'All'},
{name: 'Technology', icon: 'computer' },
{name: 'Sports', icon: 'sports_basketball' },
{name: 'Health', icon: 'health_and_safety' },
{name: 'Business', icon: 'business'},
];
app.get('/api/catagories', async(req, res) => {
    res.json({
        sucess: true,
        data: catagories
    })
} )
app.listen(process.env.PORT, console.log(`Listening on ${process.env.PORT}`))