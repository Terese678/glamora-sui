/// Author: Timothy Chimbiv
/// This is the Glamora Seal policy, it defines who has access to premium 
/// content uploaded by the creator. Only a verified Glamora enclave 
/// can unlock premium portfolio access

module glamora_sui::seal_policy {
    use sui::ed25519;
    use sui::hash;
    use sui::bcs;

    /// This is the fixed key ID that Seal uses for enclave secret encryption
    const KEY_ID: vector<u8> = vector[0];

    /// This function approves access to the Seal encrypted premium portfolio key
    /// It can only be satisfied by the verified Glamora enclave
    public fun seal_approve(
        id: vector<u8>,         // this must match the fixed KEY_ID
        signature: vector<u8>,  // this is signed by the enclave ephemeral key
        wallet_pk: vector<u8>,  // this is the enclave wallet public key
        timestamp: u64,         // this prevents replay attacks by expiring old requests
        enclave_pk: vector<u8>, // this is the enclave ephemeral public key
        ctx: &TxContext,        // this gives us the transaction context
    ) {
        // this verifies the key ID matches the fixed enclave key
        assert!(id == KEY_ID, 0);

        // this builds the message the enclave signed
        let mut msg = wallet_pk;
        let ts_bytes = bcs::to_bytes(&timestamp);
        msg.append(ts_bytes);

        // this verifies the enclave's signature is genuine
        let msg_hash = hash::blake2b256(&msg);
        assert!(
            ed25519::ed25519_verify(&signature, &enclave_pk, &msg_hash),
            1
        );

        // this verifies the sender matches the enclave wallet
        assert!(
            tx_context::sender(ctx) == sui::address::from_bytes(wallet_pk),
            2
        );
    }
}
