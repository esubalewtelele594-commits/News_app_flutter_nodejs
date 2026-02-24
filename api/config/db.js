const  mongoose = require('mongoose');
require('dotenv').config()


const mongoDB = process.env.MONGO_DB
const connectDb = async() => {
    try {
        await mongoose.connect(mongoDB)
                      .then(console.log('Datbase connection Successful'))
    } catch (error) {
        console.log('Error connecting to DB')
        console.log(error)
    }

        
}

module.exports = connectDb