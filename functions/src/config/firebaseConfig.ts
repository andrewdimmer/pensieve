import * as firebase from "firebase";

const firebaseApp = firebase.initializeApp(
  JSON.parse(process.env.FIREBASE_CONFIG as string)
);

export default firebaseApp;
