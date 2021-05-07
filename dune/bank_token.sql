/* dune_user_generated : Uniswap_v2_pairs */

/* Count Unique Tokens & Pairs */
SELECT
COUNT(DISTINCT(token0)) AS unique_token0,
COUNT(DISTINCT(token1)) AS unique_token1,
COUNT(DISTINCT(pair)) AS unique_pair
FROM dune_user_generated."uniswap_v2_pairs"
LIMIT 10


/* All trades on Uniswap V2 involving BANK tokens */
SELECT
*
FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' 
OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'

/* Number of Distinct Trading pairs with BANK token on Uniswap V2 */
/* token_a = 3, WETH, USDT, ETH */
/* token_b = 5, USDC, WETH, HEX, USDT, DAI */
WITH temp_table AS (
SELECT
*
FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
)
SELECT
COUNT(DISTINCT(token_a_symbol))
FROM temp_table


/* Number of TXN where BANK was traded for USDT, 3,034 txns and counting...*/
/* USDT token_a = 179, token_b = 240 */
/* WETH token_a = 1018, token_b = 1592 */
WITH temp_table AS (
SELECT
*
FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
)
SELECT
COUNT(token_a_symbol)
FROM temp_table
WHERE token_a_symbol = 'USDT'


