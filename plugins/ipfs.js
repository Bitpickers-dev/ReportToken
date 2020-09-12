const IPFSHttpClient = require('ipfs-http-client')
const ipfs = new IPFSHttpClient('ipfs.infura.io', '5001', {protocol: 'https'})

export {
    ipfs
}