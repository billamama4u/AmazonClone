const express = require('express');
const User = require('../models/user');
const authRouter = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ msg: 'User with the same e-mail already exists!' });
    }
    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    return res.json(user);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

authRouter.post('/api/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (!existingUser) {
      return res.status(400).json({ msg: 'User with this e-mail does not exist' });
    }
    const isMatching = await bcrypt.compare(password, existingUser.password);
    if (!isMatching) {
      return res.status(400).json({ msg: 'Incorrect password' });
    }
    const token = jwt.sign({ id: existingUser._id }, "passwordKey");
    return res.json({ token, ...existingUser._doc });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

authRouter.post('/tokenisvalid', async (req, res) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, 'passwordKey');
    if (!verified) {
      return res.json(false);
    }
    const user = await User.findById(verified.id);
    if (!user) {
      return res.json(false);
    }
    return res.json(true);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

authRouter.get('/', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    return res.json({ ...user._doc, token: req.token });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
