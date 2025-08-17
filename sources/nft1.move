// NFT Dinamico

module nft1::nft1 {
    use std::string::String;

    // Constantes
    const LEVEL_UP_XP: u64 = 100;
    const ENOT_ENOUGH_XP: u64 = 101;  // otra constante podria ser: const ENOT_OWNER: u64 = 100;

    //Estructura basica para los NFT dinamicos
    public struct Nft has key, store {
        id: UID,        //object::UID,
        // owner: address,
        name: String,    //string directamente
        description: String,
        url: String,
        level: u64,
        xp: u64,
    }

    //crear un nuevo NFT con nivel 1 y experiencia 0
    public entry fun mint (
        name: String, 
        description: String,
        url: String,
        ctx: &mut TxContext
        ){
        let nft = Nft{
            id: object::new(ctx),
            // owner: tx_context::sender(ctx),
            name,
            description,
            url,
            level: 1,
            xp: 0
        };

        // transferir el nft al que llamo
        transfer::transfer(nft, tx_context::sender(ctx));
    }

    // Ganar experiencia, nft se pasa como parametro
    public entry fun gain_xp(
        nft: &mut Nft,     //nft: Nft,   ... test  (otra opcion nft_addr: address)
        amount: u64,
        // ctx: &mut TxContext
        ) {
            // let sender = tx_context::sender(ctx);
             // assert!(nft.owner == sender, 100); // 100 = Error: No eres el dueño

        nft.xp = nft.xp + amount;
    }
        

    // Subir de nivel si tienes experiencia
    public entry fun level_up(
        nft: &mut Nft,      //nft: Nft,    ... test
        ctx: &mut TxContext
        ) {
            // let sender = tx_context::sender(ctx);
            // assert!(nft.owner == sender, 100); // 100 = Error: No eres el dueño
            assert!(nft.xp >= LEVEL_UP_XP, ENOT_ENOUGH_XP);
            nft.xp = nft.xp - LEVEL_UP_XP;
            nft.level = nft.level + 1;

            // transfer::transfer(nft, tx_context::sender(ctx));    ... test
    }

    // Consultando el nivel
    public fun get_level(nft: &Nft): u64 {
        nft.level
    }

    // consultando la experiencia
    public fun get_xp(nft: &Nft): u64 {
        nft.xp
    }


}