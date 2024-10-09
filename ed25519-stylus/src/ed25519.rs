use alloy_primitives::FixedBytes;
use alloy_sol_types::sol;
use ed25519_compact::{PublicKey, Signature};
use stylus_sdk::{evm, prelude::*};

sol_storage! {
    #[entrypoint]
    struct Ed25519VerifyBenchmark { }
}

sol! {
    event VerificationResult(bool success);

    error InvalidPublicKey(bytes32 public_key);
    error InvalidSignature(bytes signature);
}

#[derive(SolidityError)]
pub enum Ed25519Error {
    InvalidPublicKey(InvalidPublicKey),
    InvalidSignature(InvalidSignature),
}

#[public]
impl Ed25519VerifyBenchmark {
    pub fn verify(
        &mut self,
        message: Vec<u8>,
        signature_bytes: Vec<u8>,
        public_key: FixedBytes<32>,
    ) -> Result<(), Ed25519Error> {
        let Ok(pk) = PublicKey::from_slice(public_key.as_slice()) else {
            return Err(Ed25519Error::InvalidPublicKey(InvalidPublicKey {
                public_key,
            }));
        };
        let Ok(signature) = Signature::from_slice(signature_bytes.as_ref()) else {
            return Err(Ed25519Error::InvalidSignature(InvalidSignature {
                signature: signature_bytes.into(),
            }));
        };
        let result = pk.verify(message, &signature).is_ok();

        evm::log(VerificationResult { success: result });
        Ok(())
    }
}
