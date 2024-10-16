# Stylus Benchmarks

This code repository aims to benchmark the gas costs between EVM and Stylus contracts for ERC20 tokens and Ed25519 signature recovery.

```bash
# Required to run the examples
git submodule update --init --recursive
```

## Findings

Each contract project directory (`{erc20,ed25519}-{stylus,solidity}`) contains a `Justfile` which reads a local `.env` (use the provided `.env.local` templates). Read the `Justfile`s to read more on what targets they provide.

### ERC20

| Function | Stylus Gas | Solidity Gas |
|----------|------------|--------------|
| deploy   | [6366893][stylus-erc20-deploy] + [2983830][stylus-erc20-activation] | [1069722][solidity-erc20-deploy] |
| mint     | [134364][stylus-erc20-mint] | [168658][solidity-erc20-mint] |
| transfer | [128080][stylus-erc20-transfer] | [161665][solidity-erc20-transfer] |

> [!NOTE]
> [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts) was used for the Solidity ERC20
>
> [this](https://github.com/OffchainLabs/stylus-erc20) was used for the Stylus ERC20

[stylus-erc20-deploy]: 0x1b04d4232eca1dc0175b3fbe8bcd3f5ea6365a93bacccb9ac36b701ae18f04d2
[stylus-erc20-activation]: 0x1b04d4232eca1dc0175b3fbe8bcd3f5ea6365a93bacccb9ac36b701ae18f04d2
[stylus-erc20-mint]: 0x3513279c3902f98c066478c5d3b88f037c83169fce6fb034aa06c6d3cb0963fa
[stylus-erc20-transfer]: 0xe199a340fb4feb2eeac925a26930aa91d0b505dabe30593dbf7ddefd1405867d
[solidity-erc20-deploy]: 0xa659c86f1f92711ead748ca8171b8b47aab569c98a3f1a07d42bd3ca4e913bb1
[solidity-erc20-mint]: 0xebebc949658be3f47daa188cb395dcb6debd9d34f035fd2583ec1f1fd4f4c8d4
[solidity-erc20-transfer]: 0xc3dbf5b859971fb4cd262a5de4ad6a7e92628815000bb2fd6e6019b3b0613022

### Ed25519

| Function | Stylus Gas | Solidity Gas |
|----------|------------|--------------|
| deploy   | [11435412][ed25519-stylus-deploy] + [3188872][ed25519-stylus-activation] | - |
| verify   | [168714][ed25519-stylus-verify] | 184188 |

[ed25519-stylus-deploy]: 0x9ef8b9c566c1cb5fe30bb58193707b0cc217c481fb65c1eaa65c60fa61db26e7
[ed25519-stylus-activation]: 0xb1d4f93be6702e9f4fddbd49480a717ad8948396bb27d189ff624b97e14d54a9
[ed25519-stylus-verify]: 0x09fd6c7f1704b6cd9512f81d8b0fe97fe48c106bef6789428db774337a9e8bde

> [!NOTE]
> [this](https://github.com/chengwenxi/Ed25519) was used for the Solidity Ed25519
>
> [this](https://docs.rs/crate/ed25519-compact/0.1.11) was used for the Stylus Ed25519
