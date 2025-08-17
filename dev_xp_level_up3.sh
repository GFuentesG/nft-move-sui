#!/bin/bash

# Configuración
PACKAGE_ID="0x446e86156afd3cc3587a3ded63580b08cc8cab00c14b531455aec456e0ce3bc5"
MODULE_NAME="nft1"
NFT_ID="0xb6541d9b2cf433fe6651b82f4416d41f947d86eb64afff300d03101e4133135d"
GAS_BUDGET=100000000

# XP a agregar (por defecto 50 si no se pasa argumento)
XP_TO_ADD=${1:-50}
CURRENT_TIMESTAMP=$(date +%s)

# 🔧 Agregar XP
echo -e "\e[1m🔧 Agregando $XP_TO_ADD XP al NFT con timestamp $CURRENT_TIMESTAMP ...\e[0m"

set -x
sui client call \
  --package $PACKAGE_ID \
  --module $MODULE_NAME \
  --function gain_xp \
  --args $NFT_ID $XP_TO_ADD $CURRENT_TIMESTAMP \
  --gas-budget $GAS_BUDGET
set +x

# ⬆️ Subir de nivel
echo -e "\e[1m⬆️  Intentando subir de nivel...\e[0m"

set -x
sui client call \
  --package $PACKAGE_ID \
  --module $MODULE_NAME \
  --function level_up \
  --args $NFT_ID \
  --gas-budget $GAS_BUDGET
set +x

# 🔍 Consultar estado
echo -e "\e[1m🔍 Consultando estado final del NFT...\e[0m"

set -x
sui client object $NFT_ID
