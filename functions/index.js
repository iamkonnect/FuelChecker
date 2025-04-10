import { onRequest } from "firebase-functions/v2/https";
import { setGlobalOptions } from "firebase-functions/v2";
import axios from "axios";
import cors from "cors";

setGlobalOptions({
  region: "us-central1",
  memory: "256MiB",
  timeoutSeconds: 60,
});
const corsHandler = cors({ origin: true });
const handleCors = (handler) => (req, res) => {
  corsHandler(req, res, async () => {
    if (req.method === "OPTIONS") {
      res.status(204).send("");
      return;
    }
    await handler(req, res);
  });
};

const PLACES_API_KEY = process.env.GOOGLE_PLACES_KEY;
const DIRECTIONS_API_KEY = process.env.GOOGLE_DIRECTIONS_KEY;

export const getDirections = onRequest(
  { secrets: ["GOOGLE_DIRECTIONS_KEY"] },
  handleCors(async (req, res) => {
    try {
      const { origin, destination } = req.query;

      if (!origin || !destination) {
        return res.status(400).json({ error: "Missing origin or destination" });
      }

      const response = await axios.get("https://maps.googleapis.com/maps/api/directions/json", {
        params: {
          origin,
          destination,
          key: DIRECTIONS_API_KEY,
          mode: "driving",
        },
      });

      res.json(response.data);
    } catch (error) {
      console.error("Directions error:", error);
      res.status(500).json({ error: "Internal server error" });
    }
  })
);

export const getNearbyGasStations = onRequest(
  { secrets: ["GOOGLE_PLACES_KEY"] },
  handleCors(async (req, res) => {
    try {
      const { lat, lng, radius } = req.query;

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
            key: PLACES_API_KEY,
          },
        }
      );

      res.json(response.data);
    } catch (error) {
      console.error("Places error:", error);
      res.status(500).json({ error: "Internal server error" });
    }
  })
);
