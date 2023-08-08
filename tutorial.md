# From Zero to Gno.Land Hero

> _Written by @leohhhn, August 10th 2023_

In this tutorial we will enter the world of `Gno.Land`, and build our own smart contract using the `Gno` programming language. `Gno` is an interpreted version of `Go` that shares 99% of the functionality with Go, allowing us to write blockchain-specific code in a secure, battle-tested language that many developers already have in their skillset.

We will go over what Gno.Land is, and how you can use the full potential of `Gno` to build secure blockchain applications in a familiar blockchain language.

## Why Gno.Land?

// maybe talk more towards an eth dev that knows nothing about cosmos?

Gno.Land is a Layer 1 blockchain network based on Tendermint2 technology. It aims to offer security, scalability, and high-quality smart contract libraries to developers, while also being interconnected with existing Cosmos chains via IBC1.

## Tutorial/Tech overview

> _Note: Familiarity with Golang, although not a necessity, is recommended in order to follow this tutorial._

In this tutorial we will go over the necessary tools and procedures required to develop in Gno.Land. These are:

1. Environment setup
2. Generating a Gno.Land keypair with `Gnokey`
3. Writing, testing, and deploying a smart contract in `Gno` to a local node
4. Using `Gnofaucet` & `Gnoweb` to get test tokens
5. Deploying our smart contract to a local testnet

## Environment setup

Make sure you have installed the following:

- Go 1.19+
- Make (for using Makefiles)
- Git

In order to get started with development, we need to clone the full [Gno.Land repository](https://github.com/gnolang/gno):

```
git clone git@github.com:gnolang/gno.git
```

After going into the cloned repository, we can build and install the aformentioned tools with the following commands:

```
cd gno.land
make build && make install
```

This will make all of the required tools available via CLI.

The next step is building the GnoVM, which is required to compile and interpret Gno to Go.
From the `gno.land` subfolder, run the following commands:

```
cd ..
cd gnovm
make build && make install
```

This completes the environment setup.

## Generating a Gno.Land keypair with Gnokey

To interact with the `Gno.Land` blockchain, we will need to generate a keypair. This is done using the [Gnokey](https://docs.onbloc.xyz/docs/cli/gnokey) CLI tool.

To generate a new keypair and add it to local storage, run:

```
gnokey add {your keypair name}
```

Next, `Gnokey` will ask you for a password to encrypt your keypair and save it in local storage under `{your keypair name}`.
This will generate a keypair based on a random `BIP39` mnemonic phrase, which will be displayed to you shortly. Write this phrase down if you plan to use this keypair in the long run.

In order to see currently saved keypairs, run:

```
gnokey list
```

Other than generating keypairs, `gnokey` is used to interact with the Gno.Land blockchain via the CLI. `Gnokey` can fetch information about an address, call functions on smart contracts and send state changes (transactions) to the network. This will be covered later.

Here is a sample keypair named Dev:

```
$ gnokey list

0. Dev (local) - addr: g10rdr9mhc7xzlyqt9fu3nhl95jy8hmfdyws8yds pub: gpub1pgfj7ard9eg82cjtv4u4xetrwqer2dntxyfzxz3pq028mgdjsyjx6uzfcu7zu2nlmsn2yvqk458xh9trddjkta338xcqq94dfrt, path: <nil>
```

We will use the this address later.

## Writing, testing, and deployment Realms

In Gno.Land, smart contracts are called [Realms](https://docs.onbloc.xyz/introduction-to-gnoland/what-is-gnoland/concepts#realm). Here are three Gno.Land concepts we need to cover before diving into the actual development of Realms:

1. Packages vs Realms
2. Render functions
3. Paths

### Packages vs Realms

Gno.Land code can be divided into two main groups: packages & realms. Put simply, packages represent stateless code that is intended to be reused - libraries. Realms on the other hand, represent smart contracts that can hold arbitrary state and functionality, and can be deployed on-chain.

### Render functions

Each Realm can implement a `Render` function which allows the developer of the Realm to display the state the way they intend to. A render function should return a valid markdown string. Of course, similar to Solidity, Gno also has the concept of `view` functions, allowing the state of the contract to be displayed in an arbitrary UI.

### Paths

Gno.Land saves its packages and realms in a tree like structure - similar to a classic file system. You will be able to find added packages under the `"gno.land/p/"` path. When developing a smart contract in Gno, you will be able to access and import these packages through the paths they are deployed to.

Upon deployment, a developer must(?) provide a path to place their Realm instance at. This provides a quick and easy way to access the state of Realms.

Let's get started with code. We will be building a simple app that will allow users to sign up for a whitelist before a certain deadline.

                          










          asd   



     asd

























      asd

       
       
        
         
         d
          as
           


           
                 asd


## Using Gnofaucet & Gnoweb to get test tokens

We can easily access the aforementioned file system which holds all packages and realms with the use of `gnoweb`. Gnoweb will spin up a local front-end that can allow you to see already deployed packages and realms.

### Setting up Gnofaucet

To fund the faucet, we need to import an keypair with a pre-mined balance to `gnokey`. Run the following:

```
gnokey add --recover Faucet
```

Gnokey will ask you to provide a mnemonic for the keypair. Put in the following mnemonic:

```
source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast
```

To start the faucet, we first need to spin up our local node. We will also need this node to be running in order to see other tools in action, as well as deploy Realms to the local testnet. Start the node with `gnoland start`.

If the node has started successfully, you should see blocks being produced.

Then, start the faucet, serving the `dev` chain, with the `Faucet` keypair:

```
gnofaucet serve --chain-id dev Faucet
```

### Running Gnoweb

Run the `gnoweb` command from within the `gno.land` subfolder. A local front-end will be running on `127.0.0.1:8888`.

Gnoweb also provides us with a simple interface to send local testnet tokens to our address that we generated in the previous steps.

By going to `http://127.0.0.1:8888/faucet`, you will be able to input the address to send tokens to. 

By default, the faucet sends `1000000ugnot` to the provided address, which is equal to `1 GNOT` token.

In order to check the balance of your address, you can use the [query](https://docs.onbloc.xyz/docs/cli/gnokey#make-an-abci-query) functionality of `gnokey` to make an ABCI query to the node.

```
$ gnokey query bank/balances/bank/balances/g10rdr9mhc7xzlyqt9fu3nhl95jy8hmfdyws8yds

height: 0
data: "1000000ugnot"

```



