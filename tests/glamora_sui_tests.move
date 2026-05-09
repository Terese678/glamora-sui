/// These tests ensure that a creator can successfully register
/// their profile and have their metadata saved on-chain 
/// and also have their status starting as unverified 
/// untill its been approved as verified. 

#[test_only]
module glamora_sui::glamora_sui_tests {
    use glamora_sui::glamora_sui;
    use std::string;
    use sui::test_scenario;

    /// Test that Kuran can register as a Lagos Luxury creator
    #[test]
    fun test_kuran_registers_as_lagos_luxury_creator() {
        let kuran_address = @0x1;
        let mut scenario = test_scenario::begin(kuran_address);

        test_scenario::next_tx(&mut scenario, kuran_address);
        {
            let ctx = test_scenario::ctx(&mut scenario);
            glamora_sui::register_creator(
                string::utf8(b"Kuran"),
                string::utf8(b"High-end Lagos fashion creator redefining African luxury on-chain"),
                string::utf8(b"Lagos Luxury"),
                string::utf8(b"blobid-kuran-portfolio-001"),
                ctx,
            );
        };

        test_scenario::end(scenario);
    }

    /// Test that Vivi starts as unverified after registering
    #[test]
    fun test_vivi_starts_unverified() {
        let vivi_address = @0x2;
        let mut scenario = test_scenario::begin(vivi_address);

        test_scenario::next_tx(&mut scenario, vivi_address);
        {
            let ctx = test_scenario::ctx(&mut scenario);
            glamora_sui::register_creator(
                string::utf8(b"Vivi"),
                string::utf8(b"Urban streetwear creator bringing street culture on-chain"),
                string::utf8(b"Urban Streetwear"),
                string::utf8(b"blobid-vivi-portfolio-002"),
                ctx,
            );
        };

        test_scenario::next_tx(&mut scenario, vivi_address);
        {
            let creator = test_scenario::take_shared<glamora_sui::Creator>(&scenario);
            assert!(!glamora_sui::is_verified(&creator), 0);
            test_scenario::return_shared(creator);
        };

        test_scenario::end(scenario);
    }

    /// Test that Hers name is stored correctly on-chain
    #[test]
    fun test_hers_name_stored_correctly() {
        let hers_address = @0x3;
        let mut scenario = test_scenario::begin(hers_address);

        test_scenario::next_tx(&mut scenario, hers_address);
        {
            let ctx = test_scenario::ctx(&mut scenario);
            glamora_sui::register_creator(
                string::utf8(b"Hers"),
                string::utf8(b"Ankara and African print creator celebrating heritage through fashion"),
                string::utf8(b"Ankara & African Print"),
                string::utf8(b"blobid-hers-portfolio-003"),
                ctx,
            );
        };

        test_scenario::next_tx(&mut scenario, hers_address);
        {
            let creator = test_scenario::take_shared<glamora_sui::Creator>(&scenario);
            assert!(glamora_sui::get_name(&creator) == string::utf8(b"Hers"), 0);
            test_scenario::return_shared(creator);
        };

        test_scenario::end(scenario);
    }
}
