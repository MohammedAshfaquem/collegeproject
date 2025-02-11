const { onSchedule } = require("firebase-functions/v2/scheduler");
const admin = require("firebase-admin");
admin.initializeApp();

exports.deleteTodayFood = onSchedule(
  {
    schedule: "0 16 * * *", // 4:00 PM daily
    timeZone: "Asia/Kolkata",
  },
  async (context) => {
    const db = admin.firestore();
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Start of the day

    try {
      const snapshot = await db
        .collection("notes")
        .where("timestamp", ">=", admin.firestore.Timestamp.fromDate(today))
        .get();

      if (snapshot.empty) {
        console.log("No donations to delete today.");
        return null;
      }

      const batch = db.batch();
      snapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();
      console.log("All today's donations have been deleted successfully.");
    } catch (error) {
      console.error("Error deleting donations:", error);
    }

    return null;
  }
);
