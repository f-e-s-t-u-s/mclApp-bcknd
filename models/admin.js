const config = require("../config/config");
const mysql = require("mysql");

const connAttrs = mysql.createConnection(config.connection);

// login an admin
const addNewAdmin = (data) => {
  return new Promise((resolve, reject) => {
    connAttrs.query(
      "INSERT INTO admins (name, email, username, password) VALUES (?,?,?,?)",
      [data.name, data.email, data.username, data.password],
      (err, result, fields) => {
        if (err) {
          console.log(err);
          reject(err);
        }
        resolve(result);
      }
    );
  });
};

const loginAdmin = (data) => {
  return new Promise((resolve, reject) => {
    connAttrs.query(
      "SELECT * FROM admins WHERE email = ?",
      [data.email],
      (err, result, fields) => {
        if (err) {
          console.log(err);
          reject(err);
        };
        resolve(result);
      }
    );
  });
};

module.exports = { addNewAdmin, loginAdmin };
