const IPFSHttpClient = require('ipfs-http-client')
const ipfs = new IPFSHttpClient({host:'ipfs.infura.io',port:'5001', protocol:'https'})

export {
    ipfs
}