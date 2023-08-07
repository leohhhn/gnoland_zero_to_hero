# From Zero to Gno.Land Hero

> _Written by @leohhhn, August 10th 2023_

In this tutorial we will enter the world of `Gno.Land`, and build our own smart contract using the `Gno` programming language. `Gno` is an interpreted version of `Go` that shares 99% of the functionality with Go, allowing us to write blockchain-specific code in a secure, battle-tested language that many developers already have in their skillset.

We will go over what Gno.Land is, and how you can use the full potential of `Gno` to build secure blockchain applications in a familiar blockchain language.

## Why Gno.Land?

// maybe talk more towards an eth dev that knows nothing about cosmos?

Gno.Land is a Layer 1 blockchain network based on Tendermint2 technology. It aims to offer security, scalability, and high-quality smart contract libraries to developers, while also being interconnected with existing Cosmos chains via IBC1.

## Tutorial/Tech overview

> _Familiarity with Golang, although not a necessity, is recommended in order to follow this tutorial._

In this tutorial we will go over the necessary tools and procedures required to develop in Gno.Land. These are:

1. Environment setup
2. Generating a Gno.Land keypair with `Gnokey`
3. Writing, testing, and deploying a smart contract in `Gno` to a local node (mention GnoVM somewhere)
4. Using `Gnofaucet` & `Gnoweb` to get test tokens
5. Deploying our smart contract to a testnet
6. Running a local node with `Gno.Land`

Da li je gnoVM samo interpreter za Gno > Go ili je zapravo neka vrsta VMa?
da li moras da buildujes gnovm ili mozes da radis sve bez buildovanja? sta bi se desilo ako ne buildujes nista?

## Environment setup

Make sure you have installed the following:

- Go 1.19+
- Make (for using Makefiles)
- Git

In order to get started with development, we need to clone the full [Gno.Land repository](https://github.com/gnolang/gno):

`git clone git@github.com:gnolang/gno.git`

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

## Writing, testing, and deployment Realms

In Gno.Land, smart contracts are called [Realms](https://docs.onbloc.xyz/introduction-to-gnoland/what-is-gnoland/concepts#realm). Here are three `Gno.Land` concepts we need to cover before diving into the actual development:

1. Packages vs Realms
2. Paths
3. Render functions

### Packages vs Realms

// da li postoji razlika izmedju addpkg i deploymenta realma? da li ono sto razlikuje package od realm u glavnom smislu je to da realm ima init funkciju, koja updejtuje stejt upon addpkg?

Gno.Land code can be divided into two main groups: `packages` & `realms`. Put simply, `packages` represent stateless code that is intended to be reused - libraries. `Realms` on the other hand, represent smart contracts that hold arbitrary state, and can be deployed on-chain.

### Paths

// package vs realm code vs realm instance  
// takodje je confusing to da deployment realma i paketa se sve radi preko addpkg - koja je krucijalna razlika izmedju ova dva? po cemu ih GNOVM razlikuje?

Gno.Land saves its packages and realms in a tree like structure - similar to a classic file system. You will be able to find deployed packages under the .... path. When develping a smart contract in Gno, you will be able to access these packages through the paths they are deployed to.

// da li je logika da ti kad radis developemnt imas full node kod sebe paa zaaato imas sve pakete i realme u lokalnim putanjama dostupne? sta ako node postane preveliki? da li mozes da pitas remote node za pakete za development nekako?

Upon deployment, a developer must(?) provide a path to place their Realm instance at. This provides a quick and easy way to access instances of Realms through a full node. (zasto je ovo bitno, kako lepo objasniti poentu?)

### Render functions

.... nadovezivanje na putanje, why render functions make sense

Each Realm can implement a `Render` function, that will allow easy access to the state of the Realm through markdown text. .... dodati jos

## Using Gnofaucet & Gnoweb to get test tokens
