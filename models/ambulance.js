// models/ambulance.js
const config = require("../config/config");
const mysql = require("mysql");

const connAttrs = mysql.createConnection(config.connection);

module.exports = {
  addAmbulannce: async (data) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "INSERT INTO ambulances (ambulance_plate, issuing_organization, lease_expiry_date, driver_contact, ambulance_location, comments ) VALUES (?,?,?,?,?,?)",
        [
          data.plate,
          data.issuer,
          data.expiry,
          data.driver,
          data.location,
          data.comments,
        ],
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
      const request_status = "Pending";
      connAttrs.query(
        "INSERT INTO ambulance_requests (patient_id, pickup_location, destination_address, distance, patient_state, pickup_date, request_status) VALUES (?,?,?,?,?,?,?)",
        [
          data.user_id,
          data.pickup_location,
          data.destination_address,
          data.distance,
          data.patient_state,
          data.pickup_date,
          request_status,
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
  getUserAmbulanceRequests: async (user_id) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT request_id, pickup_location, destination_address, distance, pickup_date, patient_state, request_datetime, request_status FROM ambulance_requests WHERE patient_id = ?",
        [user_id],
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
  getPendingRequest: async (status) => {
    return new Promise((resolve, reject) => {
      const request_status = status;
      connAttrs.query(
        "SELECT * FROM ambulance_requests WHERE request_status = ?",
        [request_status],
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
        "SELECT * FROM ambulances WHERE in_use = ? AND in_contract = ?",
        [in_use, 1],
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
          `UPDATE ambulance_requests SET request_status = ?, ambulance_id = ? WHERE request_id = ?`,
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
