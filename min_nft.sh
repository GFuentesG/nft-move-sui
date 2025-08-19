#!/bin/bash

# Script para mintear un NFT en Sui
# https://docs.wal.app/usage/web-api.html#public-services

# Parámetros en la Mainnet
# PACKAGE_ID="0xeeba998484f1fbd685a400f385da16f41bf30fa478c938974feac4be59a3d44e"
# Parametros en la testnet
PACKAGE_ID="0x3cdc323c4cfd19b186d550d47f36aa87a2434fa9503caa26eca42e6a98461891"
MODULE="nft1"
FUNCTION="mint"
#NAME="Gold"
NAME="Zafiro"
DESCRIPTION="Gema obtenida!!!"
#IMAGE_URL="https://h2w5u-2aaaa-aaaac-qbn6q-cai.icp0.io/gold.png"
IMAGE_URL="https://aggregator.walrus-testnet.walrus.space/v1/blobs/es0ZlPJsOzCA2rXIzuFmHMx1CCupS-jKkF5ge27aGgo"
GAS_BUDGET=30000000

# Ejecutar la llamada
set -x
sui client call \
  --package $PACKAGE_ID \
  --module $MODULE \
  --function $FUNCTION \
  --args "$NAME" "$DESCRIPTION" "$IMAGE_URL" \
  --gas-budget $GAS_BUDGET