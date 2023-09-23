// models/ambulance.js
const { NOW } = require("sequelize");
const config = require("../config/config");
const mysql = require("mysql");
const { log } = require("winston");

const connAttrs = mysql.createConnection(config.connection);

module.exports = {
  addAmbulanceRequestDetails: async (data) => {
    return new Promise((resolve, reject) => {
      const status = "Pending";
      connAttrs.query(
        "INSERT INTO ambulance_requests (patient_name, pickup_location, emergency_nature, emergency_severity, status) VALUES (?,?,?,?,?)",
        [
          data.patient_name,
          data.pickup_location,
          data.emergency_nature,
          data.emergency_severity,
          status,
        ],
        (err, result, fields) => {
          if (err) {
            console.log(err);
            return reject(err);
          }
          resolve(result);
        }
      );
    });
  },
  getPendingRequest: async () => {
    return new Promise((resolve, reject) => {
      const status = "Pending";
      connAttrs.query(
        "SELECT * FROM ambulance_requests WHERE status = ?",
        [status],
        (err, results, fields) => {
          if (err) {
            console.log(err);
            return reject(err);
          }
          resolve(results);
        }
      );
    });
  },
  getAmbulance: async (data) => {
    return new Promise((resolve, reject) => {
      const in_use = data;
      console.log(in_use);
      connAttrs.query(
        "SELECT * FROM ambulances WHERE in_use = ?",
        [in_use],
        (err, resluts, fields) => {
          if (err) {
            console.log(err);
            return reject(err);
          }
          resolve(resluts);
        }
      );
    });
  },
  assignAmbulance: async () => {
    return new Promise((resolve, reject) => {
      connAttrs.query("SELECT ");
    });
  },
};
