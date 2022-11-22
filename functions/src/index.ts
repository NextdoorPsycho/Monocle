import * as admin from "firebase-admin";

admin.initializeApp({
  serviceAccountId: 'monocle-mtg@appspot.gserviceaccount.com',
  storageBucket: 'monocle-mtg.appspot.com'
});

exports.eventuser = require("./user/events");