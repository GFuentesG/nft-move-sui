# 🧬 NFT Dinámico en Move para la red Sui

Este módulo implementa un **NFT dinámico** sobre la blockchain **Sui** utilizando el lenguaje **Move**, creando activos digitales que evolucionan mediante interacciones. Perfecto para videojuegos blockchain, programas de lealtad gamificados, coleccionables interactivos, y más.

## ❓ Valor del Proyecto
Los NFTs estáticos limitan la interacción en dApps. Nuestra solución:

- 🎮 NFTs que crecen con el usuario (sistema de niveles/XP)

- 📈 Progresión verificable on-chain

- 🔄 Mecánicas de juego programables

- 🏷 Metadatos dinámicos sin migraciones

## ✨ Características Clave

| Categoría       | Beneficio                                                                 |
|-----------------|--------------------------------------------------------------------------|
| **Evolución**   | 🔼 NFTs que mejoran con el uso (sistema de niveles/XP)                    |
| **Interacción** | ⚡ Experiencia acumulable mediante transacciones                          |
| **Transparencia** | 🔍 Todo el progreso registrado en blockchain                             |
| **Extensibilidad** | 🧩 Fácil añadir nuevos atributos o mecánicas                            |


## 🧱 Estructura del NFT Dinámico

```move
public struct Nft has key, store {
    id: UID,                // Identificador único
    name: String,           // Nombre del personaje/coleccionable
    description: String,    // Lore o descripción
    url: String,            // Metadata dinámica (imagen SVG actualizable)
    level: u64,             // Nivel actual (visible en UI)
    xp: u64,                // Experiencia acumulada
    // (Pendiente): attributes: vector<u8> // Para futuras expansiones
}
```

## 🛠️ Funciones disponibles

### Creacion: `mint`
Crea un nuevo NFT dinámico

| Parámetro     | Tipo              | Descripción             |
|--------------|------------------|------------------------|
| `name`       | `String`         | Nombre del NFT         |
| `description`| `String`         | Descripción del NFT    |
| `url`        | `String`         | URL de los metadatos   |
| `ctx`        | `&mut TxContext` | Contexto de transacción|

### Interaccion: `gain_xp`
Añade experiencia a un NFT

| Parámetro | Tipo       | Descripción             |
|----------|------------|------------------------|
| `nft`    | `&mut Nft` | Referencia al NFT      |
| `amount` | `u64`      | Cantidad de XP a añadir|

### Evolucion: `level_up`
Sube de nivel el NFT (requiere 100 XP)

| Parámetro | Tipo              | Descripción             |
|----------|------------------|------------------------|
| `nft`    | `&mut Nft`       | Referencia al NFT      |
| `ctx`    | `&mut TxContext` | Contexto de transacción|

**Errores:**  
`ENOT_ENOUGH_XP` (101) - XP insuficiente para subir de nivel

### Funciones de consulta
| Función     | Retorno | Descripción          |
|------------|--------|---------------------|
| `get_level`| `u64`  | Nivel actual del NFT|
| `get_xp`   | `u64`  | XP actual del NFT   |

## 📊 Tabla de Funciones Completa
| Función        | Parámetros                     | Descripción                              | Tipo de Operación |
|----------------|-------------------------------|------------------------------------------|-------------------|
| `mint`        | name, description, url, ctx   | Crea NFT inicial (nivel 1, 0 XP)         | Escritura         |
| `gain_xp`     | nft, amount                   | Añade experiencia verificable            | Escritura         |
| `level_up`    | nft, ctx                      | Evolución a siguiente nivel              | Escritura         |
| `get_level`   | &nft                          | Consulta nivel actual                    | Lectura           |
| `get_xp`      | &nft                          | Consulta XP acumulado                    | Lectura           |

## 🚀 Casos de Uso
### 🎮 Videojuegos Play-to-Earn
```move
// Recompensa por completar misión
gain_xp(&mut player_nft, 50);
if get_xp(&player_nft) >= 100 {
    level_up(&mut player_nft, ctx);
}
```
### 🏆 Programas de Lealtad
```move
// Compra en tienda = +30 XP
gain_xp(&mut loyalty_nft, 30);
```
### 🖼 Coleccionables Evolutivos
```move
// NFT muestra diferente arte según nivel
let current_level = get_level(&collectible_nft);
```
## 🚀 Ejemplo de uso
```move
// 1. Crear nuevo NFT
mint(
    "Ninja Azul", 
    "Un poderoso guerrero ninja", 
    "https://miweb.com/ninja.png", 
    ctx
);

// 2. Ganar experiencia
gain_xp(&mut nft, 120);

// 3. Subir de nivel
level_up(&mut nft, ctx);
```

## ⚙️ Requisitos
Sui Move SDK

Compilador Move compatible con Sui

## 🛠️ Instalación
Clona el repositorio:

```bash
git clone https://github.com/tu-usuario/nft-dinamico-sui.git
cd nft-dinamico-sui
```
Compila el módulo:

```bash
sui move build
```
Ejemplo de despliegue:

```bash
sui client publish --gas-budget 10000
```

## 📈 Roadmap
- Sistema básico de niveles/XP
- Validación de propiedad antes de modificar
- Atributos dinámicos (fuerza, agilidad, etc.)
- Eventos emitidos para UI
- Soporte para metadata evolutiva

## 📝 Licencia
Licencia MIT: Permite uso libre manteniendo el copyright original, https://opensource.org/licenses/MIT
Ideal para iniciar con:

- Portafolios de desarrollo blockchain
- Integración en juegos/dApps
- Casos de estudio de NFTs dinámicos
