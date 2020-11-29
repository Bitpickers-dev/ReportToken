const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.rp = functions.pubsub.schedule('0 10 1 10,3 *').timeZone('Asia/Tokyo').onRun((_context) => {
  let db = admin.firestore()
  let users = []
  let reports = []
  let RP1Table = []
  let RP2Table = []
  let RPTable = []
  let hitNumber = null
  let totalInssuance = 0

  async function RP() {
    await db.collection('users').get().then(snapshot => {
      snapshot.forEach(doc => {
        users.push(doc.data())
      })
    })
    await db.collection('reports').orderBy('currentDownloads', 'desc').get().then(snapshot => {
      snapshot.forEach(doc => {
        reports.push(doc.data())
      })
    })

    RP1()

    RP2()

    for (let i = 0; i < users.length; i++) {
      RPTable.push({
        userAddress: users[i].address,
        RP: RP1Table[i].RP1 + RP2Table[i].RP2
      })
      await db.collection('winners').add({
        RP: RPTable[i].RP,
        winner_address: RPTable[i].userAddress,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        received: false
      }).then(() => {
      });
    }
    // 最後にcurrentDownloadsとpurchased_token_amountを0にリセットする
    updateField("reports", {currentDownloads: 0})
    updateField("users", {purchased_token_amount: 0})
  }

  function RP1() {
    for (let i = 0; i < users.length; i++) {
      RP1Table.push({
        userAddress: users[i].address,
        RP1: 0
      })
    }
    HPF()
  }

  function HPF() {
    const n = reports.length
    const numOfAbove = Math.floor(n / 2)
    for (let i = 0; i < numOfAbove; i++) {
      for (let j = 0; j < users.length; j++) {
        let shareUser = reports[i].shareUser;
        let RP1address = RP1Table[j].userAddress;
        if (shareUser === RP1address) {
          if (numOfAbove <= 8) {
            RP1Table[j].RP1 += 4 - 0.5 * i
          } else {
            RP1Table[j].RP1 += 4 - 4 * i
          }
        }
      }
    }
  }

  function RP2() {
    for (let i = 0; i < users.length; i++) {
      RP2Table.push({
        userAddress: users[i].address,
        RP2: 0
      })
    }
    for (let i = 0; i < users.length; i++) {
      totalInssuance += users[i].purchased_token_amount
    }

    for (let i = 0; i < 5; i++) {
      hitNumber = Math.floor(Math.random() * 100)
      let receiver = roulette(hitNumber, totalInssuance)
      //search user
      for (let j = 0; j < users.length; j++) {
        if (j === receiver) {
          RP2Table[j].RP2 += 1
        }
      }
    }
  }

  function roulette(h, t) {
    let rangeMin = 0
    let rangeMax = 0
    let percentage = 0
    let i = 0

    for (i; i < users.length; i++) {
      percentage = 100 * users[i].purchased_token_amount / t
      rangeMax += percentage
      if (rangeMin <= h && h <= rangeMax) {
        break
      } else {
        rangeMin = rangeMax
      }
    }
    return i
  }

  async function updateField(collection, value) {
    let batch = db.batch()
    let snapshots = await db.collection(collection).get()
    let docs = snapshots.docs.map((doc, index) => {
      //500件毎にcommitしてbatchインスタンスを初期化
      if ((index + 1) % 500 === 0) {
        batch.commit()
        batch = db.batch()
      }
      //update
      batch.update(doc.ref, value)
    });
    //最終commit
    batch.commit();
  }

  RP().then(() => {
  });
  return null;
})
;
