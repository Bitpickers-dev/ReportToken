import reportTokenABI from "@/build/contracts/ReportToken.json";
import reportInfoABI from "@/build/contracts/ReportInfo.json";
import * as reportTokenContract from "express";

const functions = require('firebase-functions');
const admin = require('firebase-admin');
let Web3 = require('web3');

admin.initializeApp();
async function cont(context, inject) {
  let web3

  if (typeof window !== 'undefined' && typeof window.ethereum !== 'undefined') {
    web3 = new Web3(window.ethereum)
    window.ethereum.enable().catch(error => {
      // User denied account access
      console.log(error)
    })
  } else if (typeof window !== 'undefined' && typeof window.web3 !== 'undefined') {
    web3 = new Web3(window.web3.currentProvider)
  } else {
    const httpEndpoint = 'http://127.0.0.1:7545'
    web3 = new Web3(new Web3.providers.HttpProvider(httpEndpoint))
  }
  let networkId = await web3.eth.net.getId()

  let reportTokenContract = new web3.eth.Contract(
    reportTokenABI.abi,
    reportTokenABI.networks[networkId].address,
  )
}

exports.rp = functions.pubsub.schedule('0 10 1 10,3 *').timeZone('Asia/Tokyo').onRun((context) => {

  let db = admin.firestore()
  let users = []
  let reports = []
  let RP1Table = []
  let RP2Table = []
  let RPTable = []
  let hitNumber = null
  let totalInssuance = 0

  var abi = [
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "userAddress",
          "type": "string"
        }
      ],
      "name": "withdraw",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
  ]

  const httpEndpoint = 'http://127.0.0.1:7545'
  Web3 = new Web3(new Web3.providers.HttpProvider(httpEndpoint))

  let networkId = Web3.eth.net.getId()

  let contract;
  contract = new Web3.eth.Contract(
    abi,
    "0x3171c90B3c0AE2001db03b911785dd5EE6A61eac",
  );


  async function RP() {
    await db.collection('users').get().then(snapshot => {
      snapshot.forEach(doc => {
        users.push(doc.data())
      })
    })
    await db.collection('reports').orderBy('downloads', 'desc').get().then(snapshot => {
      snapshot.forEach(doc => {
        reports.push(doc.data())
      })
    })

    RP1()

    RP2()

    for (let i = 0; i < 1; i++) {
      RPTable.push({
        userAddress: users[i].address,
        RP: RP1Table[i].RP1 + RP2Table[i].RP2
      })

      await db.collection('winners').add({
        RP: RPTable[i].RP,
        winner_address: RPTable[i].userAddress
      }).then(() => {
      });

      await reportTokenContract.methods.purchaseToken("0xfBEcCDe3f66eF4e16Df953367F9D17B6F21ebd0a")
        .send({
          from: "0x3171c90B3c0AE2001db03b911785dd5EE6A61eac",
          to: "0xfBEcCDe3f66eF4e16Df953367F9D17B6F21ebd0a",
        });
    }
    ;
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

  RP().then(() => {
  });
  return null;
})
;
