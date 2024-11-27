// importScripts('https://www.gstatic.com/firebasejs/9.24.0/firebase-app.js');
// importScripts('https://www.gstatic.com/firebasejs/9.24.0/firebase-messaging.js');
importScripts('https://www.gstatic.com/firebasejs/9.9.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.9.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyBlW7_VK4eNE-KtGIQ21IuZ1IwwNr23RFU",
  authDomain: "currencyconverter-61278.firebaseapp.com",
  projectId: "currencyconverter-61278",
  storageBucket: "currencyconverter-61278.firebasestorage.app",
  messagingSenderId: "881647430504",
  appId: "1:881647430504:android:79e403e08793b37ff0c4dd",
});

const messaging = firebase.messaging();

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('../firebase-messaging-sw.js')
    .then(function(registration) {
      console.log('Registration successful, scope is:', registration.scope);
    }).catch(function(err) {
      console.log('Service worker registration failed, error:', err);
    });
  }