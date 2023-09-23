// models/user.js
const config = require("../config/config");
const mysql = require("mysql");

const connAttrs = mysql.createConnection(config.connection);

module.exports = {
  /**Find Active Appointments for a patient */
  findUserActiveAppointments: async (id) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM vw_bookings WHERE user_id = ? and is_complete=0",
        [id],
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result[0]);
        }
      );
    });
  },
  /**Find a specific appointment for a specific user */
  findUserActiveAppointmentToUpdate: async (id, userId) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM vw_bookings WHERE id = ? and user_id =? and is_complete=?",
        [id, userId, 0],
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result[0]);
        }
      );
    });
  },

  /**Finding Appoitment by Id  */
  findAppointmentById: async (id) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM vw_bookings WHERE id =?",
        id,
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result[0]);
        }
      );
    });
  },

  /**Find Appointments Either completed or open */
  findAppointments: async (data) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM vw_bookings WHERE is_complete = ?",
        data.is_complete,
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result);
        }
      );
    });
  },

  /**Find Appointments Either completed or open */
  findAllAppointments: async () => {
    return new Promise((resolve, reject) => {
      connAttrs.query("SELECT * FROM vw_bookings", (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      });
    });
  },

  /**Find appointment for a specific doctor with either Coplete status or open */
  findAppointmentsDoctor: async (data) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM vw_bookings WHERE doctor_id = ? and is_complete =?",
        [data.doctor_id, data.is_complete],
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result);
        }
      );
    });
  },

  /**Find appointment for a specific user either open or closed status */
  findAppointmentsUser: async (data) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM vw_bookings WHERE user_id = ? AND is_complete=?",
        [data.user_id, data.is_complete],
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result);
        }
      );
    });
  },

/**Create a transaction for appointment */
  createTransactionForAppointment: async (transaction) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "INSERT INTO transactions SET ?",
        transaction,
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result);
        }
      );
    });
  },


  /**Create a new appointment */
  createAppointment: async (appointment) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "INSERT INTO appointments SET ?",
        appointment,
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result);
        }
      );
    });
  },
 /**Find existing prescription by appointment id */
 findPrescriptionById: async (data) => {
  return new Promise((resolve, reject) => {
    connAttrs.query(
      "SELECT * FROM appointment_prescription WHERE appointment_id = ? AND doctor_id=?", 
      [data.appointment_id, data.doctor_id],
      (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result[0]);
      }
    );
  });
},

    /**Create a new prescription */
    createPrescription: async (prescription) => {
      return new Promise((resolve, reject) => {
        connAttrs.query(
          "INSERT INTO appointment_prescription SET ?",
          prescription,
          (error, result) => {
            if (error) {
              return reject(error);
            }
            resolve(result);
          }
        );
      });
    },

/**Find existing prescription for patient */
  findPrescriptionByPatientId: async (data) => {
    return new Promise((resolve, reject) => {
      connAttrs.query(
        "SELECT * FROM appointment_prescription WHERE patient_id = ? ORDER BY ID DESC",
        [data.patient_id],
        (error, result) => {
          if (error) {
            return reject(error);
          }
          resolve(result);
        }
      );
    });
  },
  
  /**Update an existing open Appointintment  */
  updateExistingOpenAppontment: async (appointment) => {
    return new Promise((resolve, reject) => {
      const query = `UPDATE appointment SET
      service_id = ?, doctor_id = ?,
       site = ?, physical_virtual = ?,
      appointment_for = ?, distance = ?,
      amount = ?, latitude = ?,
      longitude = ?, mobile = ?,
      age = ?, disease = ?,
      chronic_yn = ?, booking_date = ?,
      updated_at = ?,
      WHERE = id =? AND is_complete=0
      `;

      const values = [
        appointment.service_id,
        appointment.doctor_id,
        appointment.site,
        appointment.physical_virtual,
        appointment.appointment_for,
        appointment.distance,
        appointment.amount,
        appointment.latitude,
        appointment.longitude,
        appointment.mobile,
        appointment.age,
        appointment.disease,
        appointment.chronic_yn,
        appointment.booking_date,
        appointment.updated_at,
        appointment.id,
      ];

      connAttrs.query(query, values, (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      });
    });
  },

  /**Patient/User canceling an appointment */
  userCancelAppointment: async (calcelData) => {
    return new Promise((resolve, reject) => {
      const query = `UPDATE appointment SET
      is_complete=3,
      canceled_by_patient = ?,
      updated_at = ?,
      WHERE = id =?
      `;

      const values = [calcelData.user_id, calcelData.updated_at, calcelData.id];

      connAttrs.query(query, values, (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      });
    });
  },
  /**Doctor canceling An appointmant */
  doctorCancelAppointment: async (calcelData) => {
    return new Promise((resolve, reject) => {
      const query = `UPDATE appointment SET
      is_complete=3,
      canceled_by_doctor = ?,
      updated_at = ?,
      WHERE = id =?
      `;

      const values = [calcelData.user_id, calcelData.updated_at, calcelData.id];

      connAttrs.query(query, values, (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      });
    });
  },

  /**Administator actvating a camceled appointment */
  adminReactivateAppointment: async (reactivateData) => {
    return new Promise((resolve, reject) => {
      const query = `UPDATE appointment SET
      is_complete=0,
      reactivated_admin = ?,
      updated_at = ?,
      WHERE = id =?
      `;

      const values = [
        reactivateData.user_id,
        reactivateData.updated_at,
        reactivateData.id,
      ];
      connAttrs.query(query, values, (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      });
    });
  },

  /**Administator actvating a camceled appointment */
  closeAppointment: async (closeData) => {
    return new Promise((resolve, reject) => {
      const query = `UPDATE appointment SET
      is_complete=1,
      closed_by = ?,
      updated_at = ?,
      WHERE = id =?
      `;

      const values = [closeData.user_id, closeData.updated_at, closeData.id];
      connAttrs.query(query, values, (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      });
    });
  },
};
