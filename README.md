## Installion

To be able to install the package you need to "Bypass only signed safe restriction" on the advanced options since this is an IPFS package33

## Usage

For now it's only compatible with AAVE Interface: https://github.com/aave/interface

After install it ti takes a while until everthing is build it, you will see this message on the logs if everything has been done correclty:

```
yarn run v1.22.19
$ npx serve out
INFO: Accepting connections at http://localhost:3000.
```

Then you have two ways to access, local served site or IPFS trough your local node:

local instance: http://decentralized-interfaces.public.dappnode:3000
IPFS i.e: http://bafybeigzt3cparrin2ntpastpzqwdz6pozccoupsuvczizyu6wf24tf7na.ipfs.ipfs.dappnode:8080

You can see both here options:

http://my.dappnode/#/packages/decentralized-interfaces.public.dappnode.eth/info

## Build
```
 npx @dappnode/dappnodesdk build                                                        
  ✔ Verify connection
  ✔ Create release dir
  ✔ Validate files
  ✔ Copy files
  ✔ Build architecture linux/amd64
  ✔ Upload release to IPFS node
  ✔ Save upload results

  DNP (DAppNode Package) built and uploaded 
  Release hash : /ipfs/QmPt3FS5pbaGRQHw4jqrReiXF6iZmtkC5mxVbJSyeT1jbg
  http://my.dappnode/#/installer/%2Fipfs%2FQmPt3FS5pbaGRQHw4jqrReiXF6iZmtkC5mxVbJSyeT1jbg
```
