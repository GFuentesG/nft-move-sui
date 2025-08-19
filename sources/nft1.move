// NFT Dinamico

module nft1::nft1 {
    use std::string::String;
    use sui::vec_map::{Self, VecMap};

    // Constantes
    const LEVEL_UP_XP: u64 = 100;
    const ENOT_ENOUGH_XP: u64 = 101;  // otra constante podria ser: const ENOT_OWNER: u64 = 100;

    const TOTAL_INTERACTIONS: u8 = 0;
    const LAST_INTERACTION_TIMESTAMP: u8 = 1;

    //Estructura basica para los NFT dinamicos
    public struct Nft has key, store {
        id: UID,        //object::UID,
        // owner: address,
        name: String,    //string directamente
        description: String,
        url: String,
        level: u64,
        xp: u64,
        stats: VecMap<u8, u64>, //Clave = tipo de estadística, Valor = dato
    }

    //crear un nuevo NFT con nivel 1 y experiencia 0
    public entry fun mint (
        name: String, 
        description: String,
        url: String,
        ctx: &mut TxContext
        ){
        let mut stats = vec_map::empty();
        stats.insert(TOTAL_INTERACTIONS, 0);

        let nft = Nft{
            id: object::new(ctx),
            // owner: tx_context::sender(ctx),
            name,
            description,
            url,
            level: 1,
            xp: 0,
            stats,
        };

        // transferir el nft al que llamo
        transfer::transfer(nft, tx_context::sender(ctx));
    }

    // Ganar experiencia, nft se pasa como parametro
    public entry fun gain_xp(
        nft: &mut Nft,     //nft: Nft,   ... test  (otra opcion nft_addr: address)
        amount: u64,
        // ctx: &mut TxContext
        current_timestamp: u64,
        ) {
            // let sender = tx_context::sender(ctx);
             // assert!(nft.owner == sender, 100); // 100 = Error: No eres el dueño

        nft.xp = nft.xp + amount;
        
        // Sumar +1 al contador de interacciones
        let key = TOTAL_INTERACTIONS;
        if (nft.stats.contains(&key)) {
            let contador = nft.stats.get_mut(&key);
            *contador = *contador + 1;
        } else {
            nft.stats.insert(key, 1);
        };

        let key2 = LAST_INTERACTION_TIMESTAMP;
        if (nft.stats.contains(&key2)) {
            let ts_ref = nft.stats.get_mut(&key2);
            *ts_ref = current_timestamp;
        } else {
            nft.stats.insert(key2, current_timestamp);
        }

    }
        

    // Subir de nivel si tienes experiencia
    public entry fun level_up(
        nft: &mut Nft,      //nft: Nft,    ... test
        //
        ) {
            // let sender = tx_context::sender(ctx);
            // assert!(nft.owner == sender, 100); // 100 = Error: No eres el dueño
            assert!(nft.xp >= LEVEL_UP_XP, ENOT_ENOUGH_XP);
            nft.xp = nft.xp - LEVEL_UP_XP;
            nft.level = nft.level + 1;

            // transfer::transfer(nft, tx_context::sender(ctx));    ... test
    }


}