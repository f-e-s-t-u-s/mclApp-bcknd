// controllers/userController.js
const Doctor = require("../models/doctors");
const bcrypt = require("bcryptjs");
const config = require("../config/config");
const jwt = require("jsonwebtoken");


module.exports = {
  getAllDoctor: async (req, res) => {
    try {
      const result = await Doctor.findDoctors();
      console.log(`${req.email}, successfully pulled doctors on ${new Date()}`);
      return res.status(202).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  getNurses: async (req, res) => {
    try {
      const result = await Doctor.findNurses();
      console.log(`${req.email}, successfully pulled Nurses on ${new Date()}`);
      return res.status(202).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  getClinician: async (req, res) => {
    try {
      const result = await Doctor.findClinician();
      console.log(
        `${req.email}, successfully pulled Clinicians on ${new Date()}`
      );
      return res.status(202).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  getDoctorsBalance: async (req, res) => {
    try {
      const result = await Doctor.findBalance(req.userId); 
      console.log(
        `${req.email}, successfully pulled Doctors Balance on ${new Date()}`
      );
      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },


  doctorById: async (req, res) => {
    const id = req.params.id;
    try {
      const result = await Doctor.findDoctorById(id);
      if (!result) {
        return res
          .status(404)
          .json({ message: "Sorry that specialist does not exist." });
      }

      console.log(
        `Doctors with id ${id}, successfully pulled on ${new Date()} `
      );

      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  addDoctor: async (req, res) => {
    const {
      name,
      username,
      email,
      mobile,
      address,
      qualification,
      speciality,
      dr_type,
      about,
      slot_type,
      serial_or_slot,
      start_time,
      end_time,
      serial_day,
      max_serial,
      duration,
      fees,
      department_id,
      location_id,
      featured,
      password,
    } = req.body;
    try {
      const doctorExist = await Doctor.findDoctorByEmail(email);
      const doctorUsernameExist = await Doctor.findDoctorByUsername(username);
      if (doctorExist || doctorUsernameExist) {
        if (doctorExist) {
          return res.status(402).json({
            message: "A user with this email already exists",
          });
        }

        if (doctorUsernameExist) {
          return res.status(402).json({
            message: "That username is already in use. Find a new one",
          });
        }
      }

      const hashedPassword = bcrypt.hashSync(
        password,
        bcrypt.genSaltSync(10),
        null
      );

      const newUser = {
        name,
        username,
        email,
        mobile,
        address,
        qualification,
        speciality,
        dr_type,
        about,
        slot_type,
        serial_or_slot,
        start_time,
        end_time,
        serial_day,
        max_serial,
        duration,
        fees,
        department_id,
        location_id,
        featured,
        password: hashedPassword,
        // updated_at: new Date(),
      };

      const result = await Doctor.createDoctor(newUser);
      console.log(`${email}, successfully registerd on ${new Date()}`);

      const subject = "Welcome to Mclinic";
      const content = `Hello, <br>
        Thank you for registering on Mclinic. <br>
        Please verify your account by clicking the link below. <br>
        <a href="http://localhost:3000/api/v1/auth/verify?email=${newUser.email}">Verify</a> <br>
        If you have any questions, please contact us at email.... `;
      /**Activate letter */
      //  const mailResult = await Email.sendEmail(newUser.email, subject, content);

      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

  updateDoctorBasic: async (req, res) => {
    // fname, lname, email, org_id, password
    const { name, username, mobile, address, email } = req.body;
    try {
      const doctor = await Doctor.findDoctorByEmail(email);
      if (!doctor) {
        return res.status(400).json({
          message:
            "Your Account is not verified. Please check your mail to verify",
        });
      }
      const newData = {
        name,
        username,
        mobile,
        address,
        email,
        updated_at: new Date(),
      };

      const result = await Doctor.updateDoctorBasic(newData);
      console.log(
        `${req.email}, successfully updated Doctor's Basicinfo on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

    updateDoctorQualification: async (req, res) => {
    // fname, lname, email, org_id, password
    const {
      academic_org_issue,
      academic_year_award,
      lincesing_org,
      level,
      linces_no,
      lincesing_year_award,
      email,
    } = req.body;
    try {
      const doctor = await Doctor.findDoctorByEmail(email);
      if (!doctor) {
        return res.status(400).json({
          message:
            "Your Account is not verified. Please check your mail to verify",
        });
      }
      const educationData = {
        institution: academic_org_issue,
        period: academic_year_award,        
        level,
        doctor_id: doctor.id,
      };
      const academicResult = await Doctor.addDoctorQualification(educationData);
      const lincensData = {        
        doctor_id: doctor.id,
        lincesing_org,
        linces_no,
        lincesing_year_award,
      };
      const lincesResult = await Doctor.addDoctorLinsence(lincensData);
      console.log(
        `${
          email
        }, successfully updated Doctor's Qualification on ${new Date()}`
      );
      return res.status(201).json({lincesResult, academicResult });
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

updateDoctorExperience: async (req, res) => {
    const {
      proffesional_org_name,
      period_from,
      period_to,
      professional_position,
      professional_role,
      accept_terms,
      email,
    } = req.body;
    try {
      const doctor = await Doctor.findDoctorByEmail(email);
      if (!doctor) {
        return res.status(400).json({
          message:
            "Your Account is not verified. Please check your mail to verify",
        });
      }
      const experienceData = {
        organization: proffesional_org_name,
        position: professional_position,
        role: professional_role,
        period_from,
        period_to,
        accept_terms,
        doctor_id: doctor.id,
      };
      const experienceResult = await Doctor.addDoctorExperience(experienceData)
      console.log(
        `${email}, successfully updated Doctor's Work Experience on ${new Date()}`
      );

 const payload = {
        email: doctor.email,
        entity_id: doctor.id,
      };

      const token = jwt.sign(payload, config.jwtSecretKey, { 
        expiresIn: "1d",
      });

      return res.status(200).json({
        user: {
          email: doctor.email,
          name: doctor.name,
          mobile: doctor.mobile,
          address: doctor.address,
          latitude: doctor.latitude,
	  longitude: doctor.longitude,
          status: doctor.status,
        },
        token,
      });

     // return res.status(200).json({experienceResult});
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },

 updateDoctorAvailability: async (req, res) => {
    const { lat, lng, status} = req.body;
	const userId = req.userId
    try {
      const user = await Doctor.findDoctorById(userId);
      if (!user) {
        return res.status(400).json({
          message:
            "Your Account is not verified. Please check your mail to verify",
        });
      }
      const newData = {
        lat,
        lng,
        status,
	userId: user.id,
        updated_at: new Date(),
      };

      const result = await Doctor.updateDoctorAvailability(newData);
      console.log(
        `${
          req.email
        }, successfully updated Doctor's availability on ${new Date()}`
      );
      return res.status(201).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  // ...other controllers...
};
