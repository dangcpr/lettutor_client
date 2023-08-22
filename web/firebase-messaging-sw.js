importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyA5Yj3gjDxn81DxDaFkNQSbuIISPq_3lzU",
  authDomain: "lettutor-d3e18.firebaseapp.com",
  projectId: "lettutor-d3e18",
  storageBucket: "lettutor-d3e18.appspot.com",
  messagingSenderId: "992762248741",
  appId: "1:992762248741:web:90bc4d2e1c27071f7c89cc",
  measurementId: "G-Y1FDHB22TB"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();