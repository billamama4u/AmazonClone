// Import packages
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors')
app.use(cors())

const PORT = process.env.PORT || 3000;
const url = "mongodb+srv://trai7078:manu3883@billa.duy1bsd.mongodb.net/?retryWrites=true&w=majority&appName=billa";

const app = express();

// Import routes
const authRouter = require('./lib/routes/auth.js');
const adminRouter = require('./lib/routes/admin.js');
const productRouter = require('./lib/routes/product.js');
const userRouter = require('./lib/routes/user.js');

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(adminRouter);
app.use(userRouter);

// Connect to MongoDB
async function connectDB() {
    try {
        await mongoose.connect(url);
        console.log("Database connection successful");
    } catch (e) {
        console.error("Error connecting to the database:", e);
    }
}

connectDB();

// Example route
app.get('/hello-world', (req, res) => {
    res.send('Hello world');
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
