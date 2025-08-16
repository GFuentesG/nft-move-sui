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


// Ejemplo de uso

// Usuario llama a mint("Ninja Azul", "https://miweb.com/ninja.png")
// Se crea un NFT con nivel 1, XP 0

// Llama a gain_xp(nft_addr, 120)
// El NFT ahora tiene 120 de experiencia

// Llama a level_up(nft_addr)
// El NFT sube a nivel 2, XP queda en 20

// Llama de nuevo a gain_xp(...) y sigue evolucionando.

// ¿Qué más se puede agregar?

// Cambiar imagen según nivel (image_url)

// Hacer que el XP necesario aumente por nivel (como en juegos reales)

// Agregar estadísticas (fuerza, velocidad, habilidades)

// Guardar el historial de evolución

// Integración con galerías o juegos externos


// ¿Cómo se usa?
// ▶️ Crear NFT
// {
//   "function": "nft1::nft1::mint",
//   "arguments": [
//     "Gato Samurai",
//     "NFT de un gato con katana y armadura.",
//     "https://miurl.com/gato_samurai.png"
//   ]
// }

// ▶️ Ganar XP
// {
//   "function": "nft1::nft1::gain_xp",
//   "arguments": [
//     "0xABC...123",  // dirección del NFT
//     150
//   ]
// }

// ▶️ Subir de nivel
// {
//   "function": "nft1::nft1::level_up",
//   "arguments": [
//     "0xABC...123"
//   ]
// }


// ¿Quieres que el nivel cambie la imagen (url) automáticamente?
// ¿O que XP necesaria para subir de nivel aumente por cada nivel?
// quemar el NFT, o listar NFTs que tiene una cuenta

// Control de acceso: asegurar que solo el dueño puede llamar a gain_xp o level_up.

// Validaciones de input: por ejemplo, no permitir valores negativos en XP (aunque sean u64).


    // #[test]
    // fun test_min_gain_level(){
    //     //contexto referencial
    //     let mut ctx = tx_context::dummy();

    //     // minteando
    //     let mut nft = mint(
    //     string::utf8(b"Ninja"),
    //     string::utf8(b"Ninja dinámico"),
    //     string::utf8(b"https://url.com/ninja.png"),
    //     &mut ctx,
    //     );

    //     // Verifica campos iniciales
    //     assert!(get_xp(&nft) == 0, 1);
    //     assert!(get_level(&nft) == 1, 2);

    //     // Aumentar XP
    //     gain_xp(&mut nft, 150, &mut ctx);
    //     assert!(get_xp(&nft) == 150, 3);

    //     // Subir de nivel
    //     level_up(&mut nft, &mut ctx);
    //     assert!(get_level(&nft) == 2, 4);
    //     }

}