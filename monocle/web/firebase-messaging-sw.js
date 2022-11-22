importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBM7KmFowwSrOBGH635ocqiN5MrMSbr1bo",
  authDomain: "monocle-mtg.firebaseapp.com",
  projectId: "monocle-mtg",
  storageBucket: "monocle-mtg.appspot.com",
  messagingSenderId: "739962222655",
  appId: "1:739962222655:web:50fe471009bf5ebfba208a",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});