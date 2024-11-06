# Stylus Benchmarks

This code repository aims to benchmark the gas costs between EVM and Stylus contracts for ERC20 tokens and Ed25519 signature recovery.

```bash
# Required to run the examples
git submodule update --init --recursive
```

## Findings

Each contract project directory (`{erc20,ed25519}-{stylus,solidity}`) contains a `Justfile` which reads a local `.env` (use the provided `.env.local` templates). Read the `Justfile`s to read more on what targets they provide.

> [!NOTE]
> For the TLDR, jump to the [conclusion](#conclusion)

> [!IMPORTANT]
> The provided numbers below are **L2_GAS** gas costs, because that's what's most important, since it represents the actual computational cost of the transactions, and not the `L1` calldata fees that are always fluctuating.
>
> Feel free to check the transactions on `arbiscan` (the gas numbers are links that take you directly there) to check the gas costs for yourself.

### ERC20


| Function  | Stylus L2 Gas | Solidity L2 Gas | Difference (L2) | % Difference |
|-----------|---------------|-----------------|-----------------|--------------|
| deploy    | [**2'868'817**][stylus-erc20-deploy] + [**2'941'842**][stylus-erc20-activation] | [**530'643**][solidity-erc20-deploy] | +2'338'174 | **995.0% more** |
| mint      | [**87'649**][stylus-erc20-mint]     | [**68'455**][solidity-erc20-mint]     | +19'194    | **28.0% more**  |
| transfer  | [**70'949**][stylus-erc20-transfer] | [**51'332**][solidity-erc20-transfer] | +19'617    | **38.2% more**  |

> [!NOTE]
> [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts) was used for the Solidity ERC20
>
> [this](https://github.com/OffchainLabs/stylus-erc20) was used for the Stylus ERC20

<!-- 6'366'893 = 3'498'076 + **2'868'817** -->
[stylus-erc20-deploy]: https://arbiscan.io/tx/0x9fce745a872d33357450c28679e03d6d534d254a13094a6750ccd88ab41b5bc8
<!-- 2'983'830 =    41'988 + **2'941'842** -->
[stylus-erc20-activation]: https://arbiscan.io/tx/0x1b04d4232eca1dc0175b3fbe8bcd3f5ea6365a93bacccb9ac36b701ae18f04d2
<!--   134'364 =    46'715 +    **87'649** -->
[stylus-erc20-mint]: https://arbiscan.io/tx/0x3513279c3902f98c066478c5d3b88f037c83169fce6fb034aa06c6d3cb0963fa
<!--   128'080 =    57'131 +    **70'949** -->
[stylus-erc20-transfer]: https://arbiscan.io/tx/0xe199a340fb4feb2eeac925a26930aa91d0b505dabe30593dbf7ddefd1405867d

<!-- 1'069'722 =   539'079 +   **530'643** -->
[solidity-erc20-deploy]: https://arbiscan.io/tx/0xa659c86f1f92711ead748ca8171b8b47aab569c98a3f1a07d42bd3ca4e913bb1
<!--   168'658 =   100'203 +    **68'455** -->
[solidity-erc20-mint]: https://arbiscan.io/tx/0xebebc949658be3f47daa188cb395dcb6debd9d34f035fd2583ec1f1fd4f4c8d4
<!--   161'665 =   110'333 +    **51'332** -->
[solidity-erc20-transfer]: https://arbiscan.io/tx/0xc3dbf5b859971fb4cd262a5de4ad6a7e92628815000bb2fd6e6019b3b0613022

### Ed25519

| Function  | Stylus L2 Gas | Solidity L2 Gas | Difference (L2) | % Difference |
|-----------|---------------|-----------------|-----------------|--------------|
| deploy    | [**3'934'896**][ed25519-stylus-deploy] + [**3'123'366**][ed25519-stylus-activation]  | [**2'814'629**][ed25519-solidity-deploy] | +1'120'267  | **39.8% more**  |
| verify    | [**225'427**][ed25519-stylus-verify]    | [**904'435**][ed25519-solidity-verify]   | -679'008    | **75% less** |

<!-- 11'435'412 = 7'500'516 + **3'934'896** -->
[ed25519-stylus-deploy]: https://arbiscan.io/tx/0x9ef8b9c566c1cb5fe30bb58193707b0cc217c481fb65c1eaa65c60fa61db26e7
<!--  3'188'872 =    65'506 + **3'123'366** -->
[ed25519-stylus-activation]: https://arbiscan.io/tx/0xb1d4f93be6702e9f4fddbd49480a717ad8948396bb27d189ff624b97e14d54a9
<!--    338'889 =   113'462 + **  225'427** -->
[ed25519-stylus-verify]: https://arbiscan.io/tx/0x2c1a00e24f38dc206659fe6eee2a9eb0e0b0687b19ad1e5b80f93a59f887edb7

<!--  6'585'440 = 3'770'811 + **2'814'629** -->
[ed25519-solidity-deploy]: https://arbiscan.io/tx/0x064432ff0f253b005023f40120028b5770a076a4321d48e6a7f5b986a98a6157
<!--  1'150'247 =   245'812 +   **904'435** -->
[ed25519-solidity-verify]: https://arbiscan.io/tx/0x7a27dad444bfe6be551e4beeca0747ac1c8374c1b100cd7612935d83472dd340

> [!NOTE]
> [this](https://github.com/chengwenxi/Ed25519) was used for the Solidity Ed25519
>
> [this](https://docs.rs/crate/ed25519-compact/0.1.11) was used for the Stylus Ed25519

## Conclusion

- For ERC-20 contracts:
  - Stylus deploy costs **~11 times more gas** than Solidity (can be optimised through [Cache Manager](https://docs.arbitrum.io/stylus/concepts/stylus-cache-manager))
  - while mint and transfer are also **~28%** and **~38%** **more expensive**, respectively

This is somewhat expected, since ERC-20 contracts aren't computationally heavy (no taking advantage of Stylus).

- For Ed25519 contracts:
  - Stylus deploy costs **~40% more gas** than Solidity (can be optimised through [Cache Manager](https://docs.arbitrum.io/stylus/concepts/stylus-cache-manager))
  - but for signature verification, Stylus is **~75% cheaper**

This is also expected and is the main takeaway from this benchmark - that Stylus is **lot** faster when doing heavy computational tasks.

### Possible optimizations for the Ed25519 Verification

- Our Solidity Ed25519 verification costs [**904k gas**][ed25519-solidity-verify], but some have optimized it to ~**500k gas**.
- [Using zk-SNARKs][zk-snark-discussion], it can go down to **300k gas** (and **still** require off-chain proving).
- And still, it costs more than Stylus's [**225k gas**][ed25519-stylus-verify].

[zk-snark-discussion]: https://ethresear.ch/t/verify-ed25519-signatures-cheaply-on-eth-using-zk-snarks/13139
