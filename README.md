# Glamora Creator Registry

**Author:** Timothy Chimbiv  
**Network:** Sui Testnet  
**Language:** Move  

## Overview

The Glamora Creator Registry stores and verifies creator identities on-chain.
It solves the problem of fake or unverifiable creator profiles by permanently
recording each creator's metadata as a unique Sui object. Once registered,
a creator's identity is transparent, tamper-proof, and owned by them.

Creator portfolio content is stored off-chain on Walrus. The returned blob ID 
is saved permanently inside the creator's on-chain profile, connecting their 
identity and their work in a decentralized and censorship resistant way.

## What It Does

- Registers fashion creators on-chain with verifiable metadata
- Each creator gets a unique on-chain object with their own UID
- Stores: name, bio, fashion category, wallet address and Walrus portfolio blob ID
- Broadcasts a CreatorRegistered event on-chain as verifiable proof of registration
- Verified status starts as false and can be updated later

## Contract Structure

- `Creator` — the on-chain object holding creator metadata
- `CreatorRegistered` — event broadcasted when a creator registers
- `register_creator` — function anyone can call to register
- `get_name` — read a creator's name
- `is_verified` — check if a creator is verified
- `get_portfolio` — fetch the Walrus blob ID linked to the creator's portfolio

## Sui Stack Layer

This contract uses the **Sui On-Chain Layer** for trusted state, ownership 
and verifiable identity, and **Walrus** for decentralized off-chain portfolio storage.

## Wallet Address

0x20ae5561647cd16dca4d8e78188913101d29781a73f5a402a267b6d4c7f0a7b5

## Deployment

**Network:** Sui Testnet  
**Package ID:** 0x309d31d8ea039f34e27bb5912413cec6a1ef9e6b4643e59999a599743cc41457  
**Transaction:** C6noVGViiqHFnjmsVCQo4HTN49RsqDjm1XyRiDMs1w8v  
**Explorer:** https://suiscan.xyz/testnet/tx/C6noVGViiqHFnjmsVCQo4HTN49RsqDjm1XyRiDMs1w8v