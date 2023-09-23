// routes/api.js
const express = require("express");
const router = express.Router();
const authController = require("../controllers/authController");
const userController = require("../controllers/userController");
const locationController = require("../controllers/locationsController");
const doctorController = require("../controllers/doctorsController");
const serviceController = require("../controllers/servicesController");
const appointmentController = require("../controllers/appointmentController");
const doctorAuthController = require("../controllers/doctorAuthController");
const authMiddleware = require("../middlewares/authMiddleware");
const {
  requestAmbulance,
  getPendingAmbulanceRequest,
  assignRequestToAmbulance,
} = require("../controllers/ambulanceController");

router.post("/signin", authController.signin);
router.post("/register", userController.register);
router.post("/signup", userController.onbording);
router.post("/verify", userController.verify);

router.post("/doctorSignin", doctorAuthController.signin);
router.post("/doctorSinup", doctorAuthController.onbording);
router.post("/doctorVerify", doctorAuthController.verify);
router.post("/doctorBasic", doctorAuthController.basicUpdate);
router.post("/doctorAcademic", doctorController.updateDoctorQualification);
router.post("/doctorExperince", doctorController.updateDoctorExperience);
router.post(
  "/doctorAvailability",
  authMiddleware.verifyToken,
  doctorController.updateDoctorAvailability
);

//
/**Location */
router.get("/locations", locationController.locations);
/**Specialities */
router.get("/specialities", locationController.specialities);

/**Doctors */
router.post("/doctor", authMiddleware.verifyToken, doctorController.addDoctor);
router.post(
  "/doctor/all",
  authMiddleware.verifyToken,
  doctorController.getAllDoctor
);

/**get Nurses  */

router.get("/nurses", doctorController.getNurses);
router.get("/nurses/:id", doctorController.doctorById);
/**Gete Clinicians */
router.get("/clinicians", doctorController.getClinician);
router.get("/clinicians/:id", doctorController.doctorById);
/**Services */
router.get("/services", serviceController.services);
router.get("/services/:id", serviceController.serviceById);
/**Appointments */
router.post(
  "/newAppointment",
  authMiddleware.verifyToken,
  appointmentController.bookAppointment
);
router.post(
  "/updateAppointment",
  authMiddleware.verifyToken,
  appointmentController.updateUpcomingAppointment
);
router.post(
  "/getAllAppointments",
  authMiddleware.verifyToken,
  appointmentController.getAllAppointments
);
router.post(
  "/openAppointments",
  authMiddleware.verifyToken,
  appointmentController.getOpenAppointments
);
router.post(
  "/closedAppointments",
  authMiddleware.verifyToken,
  appointmentController.getClosedAppointments
);
router.post(
  "/userCancelAppointment",
  authMiddleware.verifyToken,
  appointmentController.userCancelAppointment
);
router.post(
  "/doctorCancelAppointment",
  authMiddleware.verifyToken,
  appointmentController.doctorCancelAppointment
);
router.post(
  "/reactivateAppointments",
  authMiddleware.verifyToken,
  appointmentController.adminReactivateAppointment
);
// user Appointments
router.post(
  "/userOpenAppointments",
  authMiddleware.verifyToken,
  appointmentController.getUserOpenAppointments
);
router.post(
  "/userClosedAppointments",
  authMiddleware.verifyToken,
  appointmentController.getUserClosedAppointments
);
// Doctors Appointments
router.post(
  "/doctorOpenAppointments",
  authMiddleware.verifyToken,
  appointmentController.getDoctorOpenAppointments
);
router.post(
  "/doctorClosedAppointments",
  authMiddleware.verifyToken,
  appointmentController.getDoctorClosedAppointments
);
// Close appointment
router.post(
  "/closeAppointment",
  authMiddleware.verifyToken,
  appointmentController.doctorCloseAppointment
);
router.post(
  "/doctor/prescribe",
  authMiddleware.verifyToken,
  appointmentController.prescribePatient
);

router.post(
  "/doctor/balance",
  authMiddleware.verifyToken,
  doctorController.getDoctorsBalance
);

// patient pulling his prescription
router.post(
  "/patient/prescriptions",
  authMiddleware.verifyToken,
  appointmentController.getPatientsPrescription
);

// Patient Reset Password
router.post("/patient/resetCode", userController.updateUserRegCode);
router.post("/patient/resetPassword", userController.resetUserPassword);

// Doctor Reset Password
router.post("/doctor/resetCode", doctorAuthController.updateDoctorRegCode);
router.post("/doctor/resetPassword", doctorAuthController.resetDoctorPassword);

//Mpesa payment
router.post(
  "/payment/callback",
  appointmentController.makeTransactioForAppointment
);

// ! ambulance routes
// user makes request for an ambulance
router.post("/getAmbulance", requestAmbulance);

// admin gets all pending ambulance requests
router.get("/pendingRequests", getPendingAmbulanceRequest);

// admin assign request to an ambulance
router.put("/assignAmbulance/:request_id", assignRequestToAmbulance);
// ...add other endpoints here...

module.exports = router;
