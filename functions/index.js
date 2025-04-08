const functions = require("firebase-functions");
const axios = require("axios");
const cors = require("cors")({ origin: true });

// Unified CORS handler middleware
const handleCors = (handler) => (req, res) => {
  cors(req, res, async () => {
    if (req.method === "OPTIONS") {
      res.status(204).send("");
      return;
    }
    await handler(req, res);
  });
};

exports.getDirections = functions.https.onRequest(
  handleCors(async (req, res) => {
    try {
      const apiKey = process.env.GOOGLE_DIRECTIONSKEY;
      const { origin, destination } = req.query;

      // Validate input parameters
      if (!origin || !destination) {
        return res.status(400).json({ error: "Missing origin or destination parameters" });
      }

      const response = await axios.get("https://maps.googleapis.com/maps/api/directions/json", {
        params: {
          origin,
          destination,
          key: apiKey,
          mode: "driving",
          alternatives: "true",
          language: "en",
          units: "metric",
        },
        timeout: 5000,
      });

      if (response.data.status !== "OK") {
        console.error("Directions API Error:", response.data);
        return res.status(400).json({
          status: response.data.status,
          error: response.data.error_message || "Directions request failed",
        });
      }

      res.json(response.data);
    } catch (error) {
      console.error("Full Error:", error);
      res.status(500).json({
        error: "Internal server error",
        details: error.message,
        ...(process.env.NODE_ENV === "development" && { stack: error.stack }),
      });
    }
  })
);

exports.getNearbyGasStations = functions.https.onRequest(
  handleCors(async (req, res) => {
    try {
      const apiKey = process.env.GOOGLE_PLACESKEY;
      const { lat, lng, radius } = req.query;

      // Validate parameters
      if (!lat || !lng) {
        return res.status(400).json({ error: "Missing location parameters" });
      }

      const response = await axios.get(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json",
        {
          params: {
            location: `${lat},${lng}`,
            radius: radius || 5000,
            type: "gas_station",
            key: apiKey,
            language: "en",
            rankby: "prominence",
          },
          timeout: 5000,
        }
      );

      if (response.data.status !== "OK") {
        console.error("Places API Error:", response.data);
        return res.status(400).json({
          status: response.data.status,
          error: response.data.error_message || "Places request failed",
        });
      }

      // Filter and format response data
      const simplifiedResults = response.data.results.map((result) => ({
        place_id: result.place_id,
        name: result.name,
        geometry: result.geometry,
        vicinity: result.vicinity,
        rating: result.rating,
        user_ratings_total: result.user_ratings_total,
        opening_hours: result.opening_hours,
        photos: result.photos ? result.photos.slice(0, 1) : null,
      }));

      res.json({ ...response.data, results: simplifiedResults });
    } catch (error) {
      console.error("Places API Error:", error);
      res.status(500).json({
        error: "Internal server error",
        details: error.message,
        ...(process.env.NODE_ENV === "development" && { stack: error.stack }),
      });
    }
  })
);
