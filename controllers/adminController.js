const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const config = require("../config/config");
const { addNewAdmin, loginAdmin } = require("../models/admin");

// create new admin
const handleAdminSignup = async (req, res) => {
  const { name, email, username, password } = req.body;
  const hashedPass = await bcrypt.hash(password, 10);

  const data = {
    name: name,
    email: email,
    username: username,
    password: hashedPass,
  };

  try {
    const response = await addNewAdmin(data);
    console.log(response);
    return res.status(201).json({ message: "Admin added successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: true, message: "Internal Server Error" });
  }
};

// admin signin
const handleAdminSignin = async (req, res) => {
  const { email, password } = req.body;
  const data = {
    email: email,
    password: password,
  };
  const response = await loginAdmin(data);

  if (response.length === 0) {
    return res.status(401).json({ message: "Invalid login details" });
  }
  const validatePass = await bcrypt.compare(password, response[0].password);
  if (!validatePass) {
    return res.status(401).json({ message: "Invalid login details" });
  }

  //   generate token
  const tokenData = {
    email: response[0].email,
    user_id: response[0].id,
  };
  const token = jwt.sign(tokenData, config.jwtSecretKey, { expiresIn: "1d" });
  return res.status(200).json({ message: "Login Successful", token });
};

module.exports = { handleAdminSignin, handleAdminSignup };
