// Only run this as a WASM if the export-abi feature is not set.
#![cfg_attr(not(any(feature = "export-abi", test)), no_main)]
extern crate alloc;

// Modules and imports
mod erc20;

use crate::erc20::{Erc20, Erc20Error, Erc20Params};
use alloy_primitives::{Address, U256};
use stylus_sdk::{msg, prelude::*};

/// Immutable definitions
struct BozaTokenParams;
impl Erc20Params for BozaTokenParams {
    const NAME: &'static str = "BozaToken";
    const SYMBOL: &'static str = "BOZA";
    const DECIMALS: u8 = 18;
}

// Define the entrypoint as a Solidity storage object. The sol_storage! macro
// will generate Rust-equivalent structs with all fields mapped to Solidity-equivalent
// storage slots and types.
sol_storage! {
    #[entrypoint]
    struct BozaToken {
        // Allows erc20 to access BozaToken's storage and make calls
        #[borrow]
        Erc20<BozaTokenParams> erc20;
    }
}

#[public]
#[inherit(Erc20<BozaTokenParams>)]
impl BozaToken {

    /// Mints tokens
    pub fn mint(&mut self, value: U256) -> Result<(), Erc20Error> {
        self.erc20.mint(msg::sender(), value)?;
        Ok(())
    }

    /// Mints tokens to another address
    pub fn mint_to(&mut self, to: Address, value: U256) -> Result<(), Erc20Error> {
        self.erc20.mint(to, value)?;
        Ok(())
    }

    /// Burns tokens
    pub fn burn(&mut self, value: U256) -> Result<(), Erc20Error> {
        self.erc20.burn(msg::sender(), value)?;
        Ok(())
    }
}