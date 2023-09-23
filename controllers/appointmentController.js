// controllers/userController.js
const Appointment = require("../models/appointments");
const bcrypt = require("bcryptjs");

module.exports = {
  /**Get all appointments */
  getAllAppointments: async (req, res) => {
    try {
      const result = await Appointment.findAllAppointments();
      console.log(
        `${req.email}, successfully pulled all appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  /**Get all open appointments */
  getOpenAppointments: async (req, res) => {
    const appointmentData = {
      is_complete: 0,
    };
    try {
      const result = await Appointment.findAppointments(appointmentData);
      console.log(
        `${
          req.email
        }, successfully pulled all open appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  /**Get all Closed appointments */
  getClosedAppointments: async (req, res) => {
    const appointmentData = {
      is_complete: 1,
    };
    try {
      const result = await Appointment.findAppointments(appointmentData);
      console.log(
        `${
          req.email
        }, successfully pulled all Closed appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  /** Open appointments pulled by User */
  getUserOpenAppointments: async (req, res) => {
    const appointmentData = {
      is_complete: 0,
      user_id: req.userId,
    };
    try {
      const result = await Appointment.findAppointmentsUser(appointmentData);
      console.log(
        `${
          req.email
        }, successfully pulled all User open appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  /** Closed appointments Pulled by User */
  getUserClosedAppointments: async (req, res) => {
    const appointmentData = {
      is_complete: 1,
      user_id: req.userId,
    };
    try {
      const result = await Appointment.findAppointmentsUser(appointmentData);
      console.log(
        `${
          req.email
        }, successfully pulled all User Closed appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  /** Open appointments Pulled by Doctors  */
  getDoctorOpenAppointments: async (req, res) => {
    const appointmentData = {
      is_complete: 0,
      doctor_id: req.userId,
    };
    try {
      const result = await Appointment.findAppointmentsDoctor(appointmentData);
      console.log(
        `${
          req.email
        }, successfully pulled all User open appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  /**Closed appointments Pulled by Doctor */
  getDoctorClosedAppointments: async (req, res) => {
    const appointmentData = {
      is_complete: 1,
      doctor_id: req.userId,
    };
    try {
      const result = await Appointment.findAppointmentsDoctor(appointmentData);
      console.log(
        `${
          req.email
        }, successfully pulled all User open appointment on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  makeTransactioForAppointment: async (req, res) => {
    const data = req.body;
    console.log(data);
    // wrong pin error and wrong input
    if (data.Body.stkCallback.ResultCode === 2001) {
      console.log(data.Body.stkCallback.ResultDesc);
      const errorMessage = data.Body.stkCallback.ResultDesc;
      return res
        .status(400)
        .json({ message: errorMessage + " You entered the wrong pin" });
    }
    //   request cancelled by user
    if (data.Body.stkCallback.ResultCode === 1032) {
      console.log(data.Body.stkCallback.ResultDesc);
      const errorMessage = data.Body.stkCallback.ResultDesc;
      return res
        .status(400)
        .json({ message: errorMessage + " You cancelled the request" });
    }

    //
    if (!data.Body.stkCallback.CallbackMetadata) {
      console.log(data.Body);
      // todo user has insufficeint balance
      const errorMessage = data.Body.stkCallback.ResultDesc;
      return res
        .status(400)
        .json({ message: errorMessage + " You Insurficient amount" });
    }

    //   successful payment
    console.log(data.Body.stkCallback.CallbackMetadata);
    try {
      const newData = {
        transactionData: data.Body.stkCallback.CallbackMetadata,
        amount: transactionData.Item[0].Value,
        receipt: transactionData.Item[1].Value,
        date: transactionData.Item[3].Value,
        phone_number: transactionData.Item[4].Value,
      };
      const result = await Appointment.createTransactionForAppointment(newData);
      console.log(
        `${phone_number}, successfully made payement for amount ${amount} on ${new Date()}`
      );

      console.log(receipt, amount, date, phone_number);
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  /**Booking/Creating an appointment */
  bookAppointment: async (req, res) => {
    const {
      service_id,
      doctor_id,
      site,
      physical_virtual,
      appointment_for,
      distance,
      amount,
      location,
      mobile,
      age,
      disease,
      chronic_yn,
      booking_date,
    } = req.body;
    try {
      const activeAppointment = await Appointment.findUserActiveAppointments(
        req.userId
      );
      if (activeAppointment) {
        return res.status(400).json({
          message: "You have an active appointment that is almost",
        });
      }

      const newAppointment = {
        user_id: req.userId,
        service_id,
        doctor_id,
        site,
        physical_virtual,
        appointment_for,
        distance,
        amount,
        latitude: location.lat,
        longitude: location.long,
        mobile,
        age,
        disease,
        chronic_yn,
        booking_date,
      };

      const result = await Appointment.createAppointment(newAppointment);
      console.log(
        `${
          req.email
        }, successfully Booked appointment with ${doctor_id} on ${new Date()}`
      );

      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },


 /**Patients prescritions pulled by patient */
  getPatientsPrescription: async (req, res) => {
    const prescriptionData = {      
      patient_id: req.userId,
    };
    try {
      const result = await Appointment.findPrescriptionByPatientId(prescriptionData);
      console.log(
        `${
          req.email
        }, successfully pulled all His prescription ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  
  /**Prescribing an appointment */
prescribePatient: async (req, res) => {  
  const {
    appointment_id,
    patient_id,
    patient,
    doctor,
    doctor_notes,
    patient_description,
    service,
    service_id,
    suggestion
  } = req.body;

  try {
	const dataCheck = { appointment_id, doctor_id: req.userId }
 const activePrescription = await Appointment.findPrescriptionById(
        dataCheck
      );
      if (activePrescription) {
        return res.status(400).json({
          message: `That Patient is already prescribed by ${doctor}`,
        });
      }

    // Ensure that 'suggestion' is an array
    const suggestions = Array.isArray(suggestion) ? suggestion : [suggestion];

    const newPrescription = {
      appointment_id,
      patient_id,
      doctor_id: req.userId,
      patient,
      doctor,
      doctor_notes, 
      patient_description,
      service,
      service_id,
      suggestion: `${[suggestions]}`  // Use 'suggestions' instead of 'suggestion'
    };

    const resultPrescription = await Appointment.createPrescription(newPrescription); 
    console.log(
      `${req.email}, successfully Prescribed a patient on ${new Date()}`
    );
    return res.status(201).json(resultPrescription); 
  } catch (error) {
    console.error("Error occurred:", error);
    res.status(500).json({ error: true, message: "Internal Server Error" });
  }
},



  /**Updating Open Appointments */
  updateUpcomingAppointment: async (req, res) => {
    const {
      id,
      service_id,
      doctor_id,
      site,
      physical_virtual,
      appointment_for,
      distance,
      amount,
      location,
      mobile,
      age,
      disease,
      chronic_yn,
      booking_date,
    } = req.body;
    try {
      const userExistingAppointment =
        await Appointment.findUserActiveAppointmentToUpdate(id, req.userId);
      if (!userExistingAppointment) {
        return res.status(400).json({
          message: "Something weared is Up. Please consult the Administrator",
        });
      }
      const updateData = {
        id,
        user_id: req.userId,
        service_id,
        doctor_id,
        site,
        physical_virtual,
        appointment_for,
        distance,
        amount,
        latitude: location.lat,
        longitude: location.long,
        mobile,
        age,
        disease,
        chronic_yn,
        booking_date,
        updated_at: new Date(),
      };

      const result = await Appointment.updateDoctorAppontment(updateData);
      console.log(
        `${req.email}, successfully updated Appointment ${id} on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  /**Patient/User Canceling open Appointment */
  userCancelAppointment: async (req, res) => {
    const { id } = req.body;

    try {
      const userExistingAppointment =
        await Appointment.findUserActiveAppointmentToUpdate(id, req.userId);
      if (!userExistingAppointment) {
        return res.status(400).json({
          message:
            "Something went wrong, please try again later/ Consult the Admin",
        });
      }
      const cancelData = {
        id,
        user_id: req.userId,
        updated_at: new Date(),
      };

      const result = await Appointment.userCancelAppointment(cancelData);
      console.log(
        `${req.email}, successfully Canceled Appointment on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  /**Doctor cancel open Appointment */
  doctorCancelAppointment: async (req, res) => {
    const { id } = req.body;

    try {
      const userExistingAppointment = await Appointment.findAppointmentById(id);
      if (!userExistingAppointment) {
        return res.status(400).json({
          message:
            "Something went wrong, please try again later/ Consult the Admin",
        });
      }
      const cancelData = {
        id,
        user_id: req.userId,
        updated_at: new Date(),
      };

      const result = await Appointment.doctorCancelAppointment(cancelData);
      console.log(
        `${req.email}, successfully Canceled Appointment on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  /**Reactivated Cancled Appointment */

  adminReactivateAppointment: async (req, res) => {
    const { id } = req.body;

    try {
      const userExistingAppointment = await Appointment.findAppointmentById(id);
      if (!userExistingAppointment) {
        return res.status(400).json({
          message:
            "Something went wrong, please try again later/ Consult the Admin",
        });
      }
      const reactivateData = {
        id,
        user_id: req.userId,
        updated_at: new Date(),
      };

      const result = await Appointment.adminReactivateAppointment(
        reactivateData
      );
      console.log(
        `${
          req.email
        }, successfully reactivated Initially Cancelled Appointment on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  /**Close Appointment */

  doctorCloseAppointment: async (req, res) => {
    const { id } = req.body;

    try {
      const userExistingAppointment = await Appointment.findAppointmentById(id);
      if (!userExistingAppointment) {
        return res.status(400).json({
          message:
            "Something went wrong, please try again later/ Consult the Admin",
        });
      }
      const closeData = {
        id,
        user_id: req.userId,
        updated_at: new Date(),
      };

      const result = await Appointment.closeAppointment(closeData);
      console.log(
        `${req.email}, successfully Closed Appointment on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
};
