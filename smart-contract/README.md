# This is my first smart contract (Basic transaction)

## Tools that is use

- Lucid (https://lucid.spacebudz.io/)
- Blockfrost (https://docs.blockfrost.io/)

### What's done 

1. Write the script validator (***on chain-code***).

2. Generate the script.plutus file. 

3. Write the (***off chain-code***).

    a. install lucid (**With the Using Web**) or follow this link ***(https://lucid.spacebudz.io/docs/overview/import/)***  for more ways. 

    b. choisir un wallet (nami,yoroi,...)
        - grace a la cle privee
        - grace aux phrases racines
        - grace au navigateur **(qui est notre choix)**  en lui passant **api** representant le nom du wallet comme suit :  **const api = await window.cardano.nami.enable(); lucid.selectWallet(api);** uniquement pour les wallets respectant la norme ***CIP-0030 (https://github.com/cardano-foundation/CIPs/tree/master/CIP-0030)***

    c. puis renseigner l'id du reseau (cela se fait lors de l'initialisation de lucid comme suit : **const lucid = await L.Lucid.new(new L.Blockfrost("https://cardano-preview.blockfrost.io/api/v0", "preview1JXEDVldkIyBkxEUrEx3n9ll4afFK1Xj"),"Preview",);**)

    