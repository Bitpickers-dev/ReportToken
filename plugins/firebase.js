import firebase from 'firebase/app'
import 'firebase/firestore'

if (!firebase.apps.length) {
 const config = {
   apiKey: process.env.FB_API_KEY,
   authDomain: process.env.FB_AUTH_DOMAIN,
   databaseURL: process.env.FB_DATABASE_URL,
   projectId: process.env.FB_PROJECTID,
   storageBucket: process.env.FB_STORAGE_BUCKET,
   messagingSenderId: process.env.FB_MESSAGING_SENDER_ID
 }
 firebase.initializeApp(config)
}

const db = firebase.firestore()
export {
 firebase,
 db
}