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
  // user makes a request for an mbulance
  requestAmbulance: async (req, res) => {
    // todo validate inputs
    const {pickup_location, emergency_nature, user_id, emergency_severity, patient_name} = req.body;
    console.log(req.body);
    

  },
};
