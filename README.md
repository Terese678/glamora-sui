# Glamora Creator Registry

**Author:** Timothy Chimbiv  
**Network:** Sui Testnet  
**Language:** Move  

## Overview

The Glamora Creator Registry stores and verifies creator identities on-chain.
It solves the problem of fake or unverifiable creator profiles by permanently
recording each creator's metadata as a unique Sui object. Once registered,
a creator's identity is transparent, tamper-proof, and owned by them.

## What It Does

- Registers fashion creators on-chain with verifiable metadata
- Each creator gets a unique on-chain object with their own UID
- Stores: name, bio, fashion category, and wallet address
- Verified status starts as false and can be updated later

## Contract Structure

- `Creator` — the on-chain object holding creator metadata
- `register_creator` — function anyone can call to register
- `get_name` — read a creator's name
- `is_verified` — check if a creator is verified

## Sui Stack Layer

This contract uses the **Sui On-Chain Layer** handling trusted state,
ownership, and verifiable identity.

## Wallet Address

0x20ae5561647cd16dca4d8e78188913101d29781a73f5a402a267b6d4c7f0a7b5

## Deployment

**Network:** Sui Testnet  
**Package ID:** 0x0968971f80a6c1e1e4c5e9bf714fa3a4dbe9b70b122fd662b4b5e557abe1b7ca  
**Transaction:** 2tZ41yXLjLp3Hzev1qin5V79fuBhYHe6X8DKaPAw4Y1y  
**Explorer:** https://suiscan.xyz/testnet/tx/2tZ41yXLjLp3Hzev1qin5V79fuBhYHe6X8DKaPAw4Y1y