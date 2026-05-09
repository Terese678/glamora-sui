/// Author: Timothy Chimbiv
/// Glamora creator registry stores or verifies creator identity,
/// it solves the issues of fake or unverifiable creator profiles
/// it permanetly saves the creators meta-data which is their
/// name, bio, the category, wallet address. It is owned by them and 
/// remains onchain transparently.

module glamora_sui::glamora_sui {
    use std::string::String;
    use sui::event; // this will enable emitting on-chain events as proof of actions

    /// for each creator that registers, their profile is stored here
    public struct Creator has key, store {
        id: UID,        // unique on-chain ID every Sui object must have this
        name: String,   // creator's name
        bio: String,    // short description of who the creator is
        category: String, // their fashion category e.g. streetwear, luxury, etc.
        wallet: address,  // their Sui wallet address to prove they own this profile
        verified: bool,   // starts as false, can be updated to true later
        portfolio_blob_id: String, // The walrus blob ID that points to creator's off-chain portfolio
    }

    /// Broadcasted when a new creator registers on Glamora
    /// serves as on-chain proof that a creator profile was created
    public struct CreatorRegistered has copy, drop {
        creator_id: ID,
        name: String,
        portfolio_blob_id: String,
    }

    /// New creators register their profile here by calling this function
    /// to create their profile
    public fun register_creator(
        name: String,
        bio: String,
        category: String,
        portfolio_blob_id: String, // The walrus blob ID received after uploading portfolio off-chain
        ctx: &mut TxContext, // ctx gives us the caller's address and creates the unique ID
    ) {
       
        // with the details provided a creator object is built
        let creator = Creator {
            id: object::new(ctx),  // generate a new unique ID for this creator
            name,
            bio,
            category,
            wallet: tx_context::sender(ctx), // automatically capture the caller's wallet
            verified: false, // new creators start with unverified
            portfolio_blob_id, // store the Walrus blob ID on-chain
        };

        // broadcast on-chain proof that a creator profile was created
        event::emit(CreatorRegistered {
            creator_id: object::id(&creator),
            name: creator.name,
            portfolio_blob_id: creator.portfolio_blob_id,
        });
        // make the creator profile publicly readable on-chain
        transfer::share_object(creator);
    }

    /// Returns the name of a creator, this is useful for reading profile data
    public fun get_name(creator: &Creator): String {
        creator.name
    }

    /// Returns whether a creator is verified or not
    public fun is_verified(creator: &Creator): bool {
        creator.verified
    }

    /// Fetches the Walrus blob ID that links this creator's on-chain profile to their off-chain portfolio
    public fun get_portfolio(creator: &Creator): String {
        creator.portfolio_blob_id
    }
}

