const { body, validationResult } = require("express-validator");

// validation rules for requesting an ambulance
const requestAmbulanceRules = () => {
  return [
    body("patient_name")
      .isString()
      .withMessage("Invalid Input")
      .notEmpty()
      .withMessage("Name cannot be empty"),
    body("emergency_severity").isString(),
    body("emergency_nature").isString(),
    body("pickup_location")
      .isString()
      .notEmpty()
      .withMessage("Name cannot be empty"),
  ];
};

// perform validaton
const validateAmbulance = (req, res, next) => {
  const errors = validationResult(req);
  if (errors.isEmpty()) {
    return next();
  }
  //   get errors from express validator
  const extractedErrors = errors.array().map((err) => {
    return { param: err.param, msg: err.msg };
  });

  return res.status(422).json({
    errors: extractedErrors,
  });
};

// rules to validate ambulance rating
const ratingRules = () => {
  return [
    body("rating_value").isInt({ min: 1, max: 5 }).withMessage("Rating should be between 1 and 5"),
    body("comments")
      .isString()
      .isLength({ min: 5 })
      .withMessage("Commments should be atleast 5 characters"),
  ];
};

const validateRules = (req, res, next) => {
  const errors = validationResult(req);
  if (errors.isEmpty()) {
    return next();
  }
  //   get errors from express validator
  const extractedErrors = errors.array().map((err) => {
    return { param: err.param, msg: err.msg };
  });

  return res.status(422).json({
    errors: extractedErrors,
  });
};

module.exports = {
  requestAmbulanceRules,
  validateAmbulance,
  ratingRules,
  validateRules,
};
