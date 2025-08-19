#!/bin/bash

# Configuración
PACKAGE_ID="0xeeba998484f1fbd685a400f385da16f41bf30fa478c938974feac4be59a3d44e"
MODULE_NAME="nft1"
NFT_ID="0xbd53b4a52d4abbd3ca33d5be27a52b70313746070f25b18a4ed00a48affa303e"
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
