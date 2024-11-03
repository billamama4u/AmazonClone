// import package
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose'); // Correct the spelling here
const PORT = process.env.PORT || 3000;

const url = "mongodb+srv://trai7078:manu3883@billa.duy1bsd.mongodb.net/?retryWrites=true&w=majority&appName=billa";

const app = express();

// other imports
const authRouter = require('./lib/routes/auth.js');
const adminRouter = require('./lib/routes/admin.js');
const productRouter = require('./lib/routes/product.js');
const userRouter = require('./lib/routes/user.js');

// middleware
app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(adminRouter);
app.use(userRouter);
// connecting to MongoDB
async function connectDB() {
    try {
        await mongoose.connect(url);
        console.log("Connection successful");
    } catch (e) {
        console.error("Error connecting to the database:", e);
    }
}

connectDB();

app.get('/hello-world', (req, res) => {
    res.send('hello world');
});

app.listen(PORT,"0.0.0.0", () => {
    console.log(`Connected to port ${PORT}`);
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
