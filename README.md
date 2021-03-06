# chain_data

Exploring blockchain data and analytics.

## Motivation

The primary purpose of this project is to explore onchain data for various crypto projects (Ethereum & Bitcoin). In the process, we'll learn tools (SQL, GraphQL), common metrics and create dashboard(s).

### Phase 1: Dune Analytics

We'll start with [Dune Analytics](https://duneanalytics.com/home); a perfect opportunity to deepen SQL skills. We will:

- write explainer for 5 useful dashboards to know
- [Introductory Ethereum Metrics](https://duneanalytics.com/kroeger0x/ethereum-metrics_1), see Charts from the Ethereum Network ([link](https://etherchain.org/charts)), Network Statistics ([link](https://ethstats.io/))
- **Sync intro ethereum metrics on Dune w/ Ethereum.org Block Explorer content**
- **_Goal: Make Tutorial for Querying Ethereum with Dune Analytics on Ethereum.org_**

- [BAT Token](https://duneanalytics.com/queries/27776): Support essay demonstrating BAT as a Web3 browser. Query BAT Token to demonstrate supply & demand

- [GRT Token](https://ethereum.org/en/developers/tutorials/the-graph-fixing-web3-data-querying): Exploring GRT Token supply/demand. The Graph Protocol appears to be the preferred data query solution for Ethereum.

- [Open Sea](https://etherscan.io/accounts/label/opensea)

- [DEX metrics](https://duneanalytics.com/hagaetc/dex-metrics)
- [BTC on Ethereum](https://duneanalytics.com/eliasimos/btc-on-ethereum_1)
- [Uniswap Fundamentals](https://duneanalytics.com/carrawu/uniswap-analytics)
- [Uniswap Governance](https://duneanalytics.com/lsquared/uniswap-governance)
- [Tornado Cash, Privacy on Ethereum](https://duneanalytics.com/poma/tornado-cash_1)
- [Lending, Compound MakerDAO Aave](https://duneanalytics.com/hagaetc/lending)

- Dashboards the need updating:
- [DeFi Pulse](https://duneanalytics.com/RasterlyRock/defi-weekly-pulse)

- Projects on Dune:
- [Compound](https://duneanalytics.com/projects/compound)
- [Aave](https://duneanalytics.com/projects/aave)

- write an explainer for the Top SQL 10 Queries you found.

Then, we'll also do [The Graph Protocol](https://thegraph.com/). We'll start with GraphQL to create sub-graphs. Then we'll query our own sub-graph.

_Note_: Also join discord for these projects.

### Phase 1 Outcomes

0. The Rise of Blockchain Querying (Trend Analysis)

1. A SQL primer to explore Ethereum on Dune Analytics. [Tool]
   1a. Match Intro Ethereum (Dune) w/ Ethereum Block Explorer [ethereum.org](https://ethereum.org/en/developers/docs/data-and-analytics/block-explorers/)

2. Top 10 Projects in DeFi, by the numbers in both SQL. Build a [Dashboard]
   2a. See if possible to do a [rabbithole quest](https://rabbithole.gg/quests) on any coins.

3. Top 10 Metrics investors use to evaluate DeFi projects [Metrics] [Queries]
4. Join Dune Discord
5. Reflections on phase 1 (falling down the rabbit hole yet?)

### Phase 2 The Graph Protocol

Start with the Graph Explorer:

Start with [this article on Ethereum.org](https://ethereum.org/en/developers/tutorials/the-graph-fixing-web3-data-querying/)

Then explore The Graph Documentation:

- Define a Subgraph
- Deploy a Subgraph
- Query The Graph
- GraphQL API
- join community

### Phase 2 Outcomes

1. Write a primer on The Graph [Documentation](https://thegraph.com/docs/introduction)
2. A GraphQL primer to create sub-graphs. [Tool]
3. Top 10 Projects in DeFi, by the numbers in both SQL and GraphQL. [Dashboard]
4. Join community
5. Reflections on phase 2 (falling down the rabbit hole yet?)

### Beyond

- [BitQuery](https://bitquery.io/), competitor of The Graph, also uses GraphQL APIs
- Etherscan
- CoinMetrics [Community Network Data](https://coinmetrics.io/community-network-data/)
- GlassNode [Metric](https://glassnode.com/metrics#tier-1) & [Glassnode Academy](https://academy.glassnode.com/indicators/coin-issuance/puell-multiple)
- [Bitcoin Energy Usage](https://www.bitcoinwillnotboiltheocean.com/) data
- Projects in the Data/Analytics section of this [graphic](https://twitter.com/n2ckchong/status/1373533273398243328/photo/1)

## Code, Libraries and Resources Used

- [Etherscan](https://etherscan.io/) to look up Smart Contract addresses

- [Dune Snippets](https://github.com/sambacha/dune-snippets)
- [Dune Discord](https://discord.com/invite/ErrzwBz)

### Blog Post Resources

- [Explore Ethereum Data with SQL queries on Dune Analytics](https://ethereumdev.io/explore-ethereum-data-with-sql-queries-on-dune-analytics/)
- [Sample query ERC20 transfers](https://duneanalytics.com/queries/1045/source#1760)
- [Understand the ERC20 token smart contract](https://ethereumdev.io/understand-the-erc20-token-smart-contract/) - to properly query ERC20 tokens
- [APIs and services every Ethereum developer should know](https://ethereumdev.io/apis-and-services-every-ethereum-developer-should-know/)

- [A complete guide to creating sub-graphs on The Graph Protocol](https://medium.com/quiknode/an-intro-to-the-graph-indexed-data-for-dapps-4d83011d0d99)

## Documenting Progress

- 3/29: Creating intro to Ethereum dashboard with basic queries: Number of blocks per day, Average difficulty, Unique miners per day, Total Gas usage, Block Gas limit, Unique Addresses (Timed Out)
- Intro to Ethereum: Next Step: Continue working to create dashboard that matches Etherscan.io
- 3/30: Create query for BAT Token Daily Value Transfer & Total Borrows of BAT Token. Learn anatomy of [querying a specific token](https://ethereumdev.io/explore-ethereum-data-with-sql-queries-on-dune-analytics/)
- 3/31 - 1/4: Create query for GRT Token; query specific contract_address or symbol.
- GRT Token Transfer Amount, Transfer Count, Unique Receivers of GRT Token, Unique Senders of GRT Token, Unique Owners of GRT (Total value head), & Top 100 Owner, Spender; Number of Unique Owner vs Owner (unique owner != owner).

- 4/4: Comb through [DEX Metrics dashboard](https://duneanalytics.com/hagaetc/dex-metrics) in Dune Analytics, write explainer on SQL queries.
- 4/8: Idea: Link Ethereum Intro on Dune to Block Explorer article on ethereum.org
- Explore [Open Sea Dashboard](https://duneanalytics.com/queries/3469/6913), break out the components to understand Open Sea smart contract
- distinguish OpenSea address vs OpenSea Wallet, OpenSea: Registry, OpenSea: ENS Resolver [link](https://etherscan.io/accounts/label/opensea)
- wyvern protocol: atomicMatch & OrdersMatched
- **Dune Queries for Open Sea**: addrs, 2 wyvern tables, token, erc20.tokens, prices.usd (_note_: no duplicate strings, make querying part of fast data display and reproducible).

- 4/9: **Rise of Blockchain Querying Trend Analysis**

## Absolute Beginner for SQL & Dune Analytic Tips:

1. There are multiple transactions per day, so to visualize a Time Series, it helps to use DATE_TRUNC('day', evt_block_time) AS date
2. Need to use GROUP BY date (x-axis)
3. If grouping by date, then the y-axis needs to be aggregated, COUNT or SUM
4. For ERC-20 Tokens, query [etherscan.io](https://etherscan.io/) to reconcile contract addresses
5. Joining two tables via UNION ALL and INNER JOIN

## Getting Data

## EDA

## Analysis

## Results

## Presentation / Productionization
