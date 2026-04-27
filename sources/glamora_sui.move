/// Author: Timothy Chimbiv
/// Glamora creator registry stores or verifies creator identity,
/// it solves the issues of fake or unverifiable creator profiles
/// it permanetly saves the creators meta-data which is their
/// name, bio, the category, wallet address. It is owned by them and 
// remains onchain transparently.

module glamora_sui::glamora_sui {
    use std::string::String;

    /// for each creator that registers, their profile is stored here
    public struct Creator has key, store {
        id: UID,        // unique on-chain ID every Sui object must have this
        name: String,   // creator's name
        bio: String,    // short description of who the creator is
        category: String, // their fashion category e.g. streetwear, luxury, etc.
        wallet: address,  // their Sui wallet address to prove they own this profile
        verified: bool,   // starts as false, can be updated to true later
    }

    /// New creators register their profile here by calling this function
    /// to create their profile
    public fun register_creator(
        name: String,
        bio: String,
        category: String,
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
        };
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
}

