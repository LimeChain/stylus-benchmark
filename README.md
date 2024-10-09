# Stylus Benchmarks

This code repository aims to benchmark the gas costs between EVM and Stylus contracts for ERC20 tokens and Ed25519 signature recovery.

## Findings

Each contract project directory (`{erc20,ed25519}-{stylus,solidity}`) contains a `Justfile` which reads a local `.env` (use the provided `.env.local` templates). Read the `Justfile`s to read more on what targets they provide.

### ERC20

| Function | Stylus Gas | Solidity Gas |
|----------|------------|--------------|
| deploy   | TODO       | TODO         |
| mint     | TODO       | TODO         |
| transfer | TODO       | TODO         |

> [!NOTE]
> [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts) was used for the Solidity ERC20
>
> [this](https://github.com/OffchainLabs/stylus-erc20) was used for the Stylus ERC20

### Ed25519

| Function | Stylus Gas | Solidity Gas |
|----------|------------|--------------|
| deploy   | TODO       | TODO         |
| verify   | TODO       | TODO         |

> [!NOTE]
> [this](https://github.com/chengwenxi/Ed25519) was used for the Solidity Ed25519
>
> [this](https://docs.rs/crate/ed25519-compact/0.1.11) was used for the Stylus Ed25519

