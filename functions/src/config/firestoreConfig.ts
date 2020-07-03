import firebaseApp from "./firebaseConfig";

export const notesRef = firebaseApp.firestore().collection("notes");

export const tagsRef = firebaseApp.firestore().collection("tags");
