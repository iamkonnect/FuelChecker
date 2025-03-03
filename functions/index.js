const functions = require("firebase-functions");
const axios = require("axios");

exports.getDirections = functions.https.onRequest(async (req, res) => {
  // Enable CORS
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET");

  // Handle preflight requests
  if (req.method === "OPTIONS") {
    res.end();
    return;
  }
  // eslint-disable-next-line object-curly-spacing
  const { origin, destination } = req.query;
  // eslint-disable-next-line max-len
  const apiKey = "AIzaSyAsCuHDu2BRITXGGUvEU4kZiwUlK4KEnxU"; // Replace with your API key

  try {
    const url = `https://maps.googleapis.com/maps/api/directions/json?origin=${origin}&destination=${destination}&key=${apiKey}`;
    const response = await axios.get(url);
    res.json(response.data);
  } catch (error) {
    console.error("Error fetching directions:", error);
    // eslint-disable-next-line object-curly-spacing
    res.status(500).json({ error: "Failed to fetch directions" });
  }
});
