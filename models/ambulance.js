// models/ambulance.js
const config = require("../config/config");
const mysql = require("mysql");

const connAttrs = mysql.createConnection(config.connection);

module.exports = {
  addAmbulannce: async ({ ambulance_plate, issuing_organization }) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "INSERT INTO ambulances (ambulance_plate, issuing_organization) VALUES (?,?)",
        [ambulance_plate, issuing_organization],
        (err, results, fields) => {
          if (err) {
            console.log(err);
            reject(err);
          }
          resolve(results);
        }
      );
    });
  },
  deleteAmbulance: async (ambulance_id) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        // `DELETE FROM ambulances WHERE ambulance_id = ?`,
        `UPDATE ambulances SET in_contract = ? WHERE ambulance_id = ?`,
        [0, ambulance_id],
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
  assignAmbulance: async ({ request_id, ambulance_id }) => {
    console.log(request_id, ambulance_id);
    const status = "Dispatched";
    return new Promise((resolve, reject) => {
      // start transaction
      connAttrs.beginTransaction((err) => {
        if (err) {
          return reject(err);
        }

        // Update the ambulance_requests table
        connAttrs.query(
          `UPDATE ambulance_requests SET status = ?, ambulance_id = ? WHERE request_id = ?`,
          [status, ambulance_id, request_id],
          (err, results, fields) => {
            if (err) {
              connAttrs.rollback(() => {
                console.log(err);
                return reject(err);
              });
            }

            // Updatein_use in table ambulances
            connAttrs.query(
              `UPDATE ambulances SET in_use = TRUE, current_request_id = ? WHERE ambulance_id = ?`,
              [request_id, ambulance_id],
              (err, results, fields) => {
                if (err) {
                  connAttrs.rollback(() => {
                    console.log(err);
                    return reject(err);
                  });
                }

                // Commit transaction
                connAttrs.commit((err) => {
                  if (err) {
                    connAttrs.rollback(() => {
                      console.log(err);
                      return reject(err);
                    });
                  }
                  resolve(results);
                });
              }
            );
          }
        );
      });
    });
  },
  addAmbulanceRating: async ({ rating_value, comments, request_id }) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "INSERT INTO ratings (rating_value, comments, request_id) VALUES (?,?,?)",
        [rating_value, comments, request_id],
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
};
