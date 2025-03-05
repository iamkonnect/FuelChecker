const functions = require("firebase-functions");
const axios = require("axios");

exports.getDirections = functions.https.onRequest(async (req, res) => {
  // CORS Handling
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET");

  if (req.method === "OPTIONS") {
    res.status(204).send("");
    return;
  }

  try {
    const apiKey = process.env.GOOGLE_DIRECTIONSKEY;
    // eslint-disable-next-line object-curly-spacing
    const { origin, destination } = req.query;

    if (!origin || !destination) {
      return res.status(400).json({
        error: "Missing origin or destination parameters",
      });
    }
    /* eslint-disable object-curly-spacing, indent */
    const response = await axios.get(
      "https://maps.googleapis.com/maps/api/directions/json",
      {
        params: {
          origin,
          destination,
          key: apiKey,
          mode: "driving", // Explicitly set travel mode
        },
      }
    );
    /* eslint-disable object-curly-spacing, indent */
    if (response.data.status !== "OK") {
      console.error("Directions API Error:", response.data);
      return res.status(400).json({
        status: response.data.status,
        error: response.data.error_message || "No error message",
      });
    }

    res.json(response.data);
  } catch (error) {
    console.error("Full Error:", error);
    res.status(500).json({
      error: "Internal server error",
      details: error.message,
      stack: error.stack,
    });
  }
});

// const functions = require("firebase-functions");
// const axios = require("axios");

// exports.getDirections = functions.https.onRequest(async (req, res) => {
//   // Simple API key verification
//   const clientKey = req.headers["x-api-key"];
//   if (clientKey !== "YOUR_CLIENT_SECRET") {
//     // eslint-disable-next-line object-curly-spacing
//     return res.status(401).json({ error: "Unauthorized" });
//   }

//   // CORS Handling
//   res.set("Access-Control-Allow-Origin", "*");
//   res.set("Access-Control-Allow-Methods", "GET");

//   if (req.method === "OPTIONS") {
//     res.end();
//     return;
//   }

//   const apiKey = process.env.GOOGLE_DIRECTIONSKEY;
//   // eslint-disable-next-line object-curly-spacing
//   const { origin, destination } = req.query;

//   try {
//     /* eslint-disable object-curly-spacing, indent */
//     const response = await axios.get(
//       "https://maps.googleapis.com/maps/api/directions/json",
//       {
//         params: {
//           origin,
//           destination,
//           key: apiKey,
//         }, // <-- Trailing comma added
//       } // <-- Trailing comma added
//     );
//     /* eslint-enable object-curly-spacing, indent */

//     if (response.data.status !== "OK") {
//       console.error("Directions API Error:", response.data);
//       // eslint-disable-next-line object-curly-spacing
//       return res.status(400).json({
//         status: response.data.status,
//         error: response.data.error_message,
//       }); // <-- Trailing comma added
//     }

//     res.json(response.data);
//   } catch (error) {
//     console.error("Server Error:", error);
//     // eslint-disable-next-line object-curly-spacing
//     res.status(500).json({
//       error: "Internal server error",
//       details: error.message,
//     }); // <-- Trailing comma added
//   }
// });
