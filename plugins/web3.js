import Web3 from "web3"
import artifacts from "~~/build/contracts/ReportToken.json"

export default async function(context, inject) {
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

  let contract = new web3.eth.Contract(
    artifacts.abi,
    artifacts.networks[networkId].address
  )

  inject('web3',web3)
  inject('contract',contract)
}
