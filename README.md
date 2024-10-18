# Stylus Benchmarks

This code repository aims to benchmark the gas costs between EVM and Stylus contracts for ERC20 tokens and Ed25519 signature recovery.

```bash
# Required to run the examples
git submodule update --init --recursive
```

## Findings

Each contract project directory (`{erc20,ed25519}-{stylus,solidity}`) contains a `Justfile` which reads a local `.env` (use the provided `.env.local` templates). Read the `Justfile`s to read more on what targets they provide.

> [!IMPORTANT]
> The provided gas numbers are L2 gas only, please check the transactions on `arbiscan` or read the `README.md` source to see the L1 and total gas costs.

### ERC20

| Function | Stylus Gas | Solidity Gas |
|----------|------------|--------------|
| deploy   | [2'868'817][stylus-erc20-deploy] + [2'941'842][stylus-erc20-activation] | [530'643][solidity-erc20-deploy] |
| mint     | [87'649][stylus-erc20-mint] | [68'455][solidity-erc20-mint] |
| transfer | [70'949][stylus-erc20-transfer] | [51'332][solidity-erc20-transfer] |


> [!NOTE]
> [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts) was used for the Solidity ERC20
>
> [this](https://github.com/OffchainLabs/stylus-erc20) was used for the Stylus ERC20

<!-- 6'366'893 = 3'498'076 + 2'868'817 -->
[stylus-erc20-deploy]: https://arbiscan.io/tx/0x9fce745a872d33357450c28679e03d6d534d254a13094a6750ccd88ab41b5bc8
<!-- 2'983'830 =    41'988 + 2'941'842 -->
[stylus-erc20-activation]: https://arbiscan.io/tx/0x1b04d4232eca1dc0175b3fbe8bcd3f5ea6365a93bacccb9ac36b701ae18f04d2
<!--   134'364 =    46'715 +    87'649 -->
[stylus-erc20-mint]: https://arbiscan.io/tx/0x3513279c3902f98c066478c5d3b88f037c83169fce6fb034aa06c6d3cb0963fa
<!--   128'080 =    57'131 +    70'949 -->
[stylus-erc20-transfer]: https://arbiscan.io/tx/0xe199a340fb4feb2eeac925a26930aa91d0b505dabe30593dbf7ddefd1405867d

<!-- 1'069'722 =   539'079 +   530'643 -->
[solidity-erc20-deploy]: https://arbiscan.io/tx/0xa659c86f1f92711ead748ca8171b8b47aab569c98a3f1a07d42bd3ca4e913bb1
<!--   168'658 =   100'203 +    68'455 -->
[solidity-erc20-mint]: https://arbiscan.io/tx/0xebebc949658be3f47daa188cb395dcb6debd9d34f035fd2583ec1f1fd4f4c8d4
<!--   161'665 =   110'333 +    51'332 -->
[solidity-erc20-transfer]: https://arbiscan.io/tx/0xc3dbf5b859971fb4cd262a5de4ad6a7e92628815000bb2fd6e6019b3b0613022

### Ed25519

| Function | Stylus Gas | Solidity Gas |
|----------|------------|--------------|
| deploy   | [3,934,896][ed25519-stylus-deploy] + [3,123,366][ed25519-stylus-activation] | - |
| verify   | [38,668][ed25519-stylus-verify] | 184'188 |

<!-- 11,435,412 = 7,500,516 + 3,934,896 -->
[ed25519-stylus-deploy]: https://arbiscan.io/tx/0x9ef8b9c566c1cb5fe30bb58193707b0cc217c481fb65c1eaa65c60fa61db26e7
<!--  3,188,872 =    65,506 + 3,123,366 -->
[ed25519-stylus-activation]: https://arbiscan.io/tx/0xb1d4f93be6702e9f4fddbd49480a717ad8948396bb27d189ff624b97e14d54a9
<!--    168,714 =   130,046 +    38,668 -->
[ed25519-stylus-verify]: https://arbiscan.io/tx/0x09fd6c7f1704b6cd9512f81d8b0fe97fe48c106bef6789428db774337a9e8bde

> [!NOTE]
> [this](https://github.com/chengwenxi/Ed25519) was used for the Solidity Ed25519
>
> [this](https://docs.rs/crate/ed25519-compact/0.1.11) was used for the Stylus Ed25519
