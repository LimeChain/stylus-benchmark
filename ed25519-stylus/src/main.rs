#[cfg(feature = "export-abi")]
fn main() {
    stylus_ed25519::ed25519::print_abi("MIT-OR-APACHE-2.0", "pragma solidity ^0.8.23;");
}
