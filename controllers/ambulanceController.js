const ambulance = require("../models/ambulance");

// chek payment
// POST request-ambulance status:pending
// GET ambulance-requests
// PUT assign-ambulance/:request-id re-update ambulance status here status:dispatched
// PUT update-ambulance locations  (later)
// PUT ambulance-arrived?/:request-id status:arrived
// PUt patient-arrived?/>request-id  re-update ambulance status here status:complete
// pOST rate-ambulane/:request_id

module.exports = {
  // admin adds ambulnce
  addNewAmbulance: async (req, res) => {
    const { ambulance_plate, issuing_organization } = req.body;
    try {
      const response = await ambulance.addAmbulannce({
        ambulance_plate,
        issuing_organization,
      });
      console.log(response);
      return res.status(200).json({ message: "Ambulance added successfully" });
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  deleteAmbulance: async (req, res) => {
    try {
      const { ambulance_id } = req.body;
      const response = await ambulance.deleteAmbulance(ambulance_id);
      console.log(response);
      return res.status(200).json({message: "Ambulance deleted successfully"})
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  // user makes a request for an mbulance
  requestAmbulance: async (req, res) => {
    // todo validate inputs
    const {
      pickup_location,
      emergency_nature,
      user_id,
      emergency_severity,
      patient_name,
    } = req.body;
    console.log(req.body);
    const data = {
      pickup_location: pickup_location,
      emergency_nature: emergency_nature,
      emergency_severity: emergency_severity,
      patient_name: patient_name,
    };

    try {
      const response = await ambulance.addAmbulanceRequestDetails(data);
      console.log(response);
      return res
        .status(200)
        .json({ message: "Request submitted successfully" });
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  getPendingAmbulanceRequest: async (req, res) => {
    try {
      const response = await ambulance.getPendingRequest();
      //   console.log(response);
      return res.status(200).json(response);
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  getAmbulancesQuery: async (req, res) => {
    const { in_use } = req.query;
    try {
      const response = await ambulance.getAmbulance(in_use);
      return res.status(200).json(response);
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  assignRequestToAmbulance: async (req, res) => {
    const { request_id, ambulance_id } = req.query;
    try {
      const response = await ambulance.assignAmbulance({
        request_id,
        ambulance_id,
      });
      console.log(response);
      return res
        .status(200)
        .json({ message: "Ambulance dispatched successfully" });
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  ambulanceReview: async (req, res) => {
    // todo validate inputs
    const { rating_value, comments, request_id } = req.body;
    console.log(req.body);
    try {
      const response = await ambulance.addAmbulanceRating({
        rating_value,
        comments,
        request_id,
      });
      console.log(response);
      return res.status(200).json({ message: "Comment posted successfully" });
    } catch (error) {
      console.log(error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
};
