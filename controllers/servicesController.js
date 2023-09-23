const Service = require("../models/service");

module.exports = {
  services: async (req, res) => {
    try {
      const result = await Service.findSerrvices();
      if (!result) {
        return res.status(404).json({ message: "Sorry no Services setup." });
      }

      console.log(`Service, successfully pulled on ${new Date()} `);

      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
  serviceById: async (req, res) => {
    const id = req.params.id;
    try {
      const result = await Service.findServiceById(id);
      if (!result) {
        return res
          .status(404)
          .json({ message: "Sorry thet service does not exist." });
      }

      console.log(
        `Service with id ${id}, successfully pulled on ${new Date()} `
      );

      return res.status(200).json(result);
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).json({ error: true, message: "Internal Server Error" });
    }
  },
};
