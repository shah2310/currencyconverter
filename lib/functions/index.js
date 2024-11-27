const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios");

admin.initializeApp();

exports.checkAlerts = functions.pubsub.schedule("every 15 minutes").onRun(async (context) => {
  try {
    const alertsSnapshot = await admin.firestore().collection("alerts").get();
    const alerts = alertsSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

    for (const alert of alerts) {
      const { baseCurrency, convertCurrency, convertRate, fcmToken } = alert;

      const response = await axios.get(`https://api.exchangerate-api.com/v4/latest/${baseCurrency}`);
      const currentRate = response.data.rates[convertCurrency];

      if (currentRate >= convertRate) {
        await admin.messaging().send({
          notification: {
            title: "Exchange Rate Alert!",
            body: `1 ${baseCurrency} = ${currentRate} ${convertCurrency}, which meets your alert condition!`,
          },
          token: fcmToken,
        });

        await admin.firestore().collection("alerts").doc(alert.id).delete();
      }
    }

    return null;
  } catch (error) {
    console.error("Error processing alerts:", error);
    return null;
  }
});
