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

/* Tokens Traded Against BANK Tokens on Uniswap V2 */
WITH prices AS (   -- Get usd prices last 24 hours                                                                                     
    SELECT  minute,                                                         
            contract_address,                                                                              
            price                                                                                
    FROM prices.usd                                                                                    
    WHERE minute >= now() - interval '30 days'
),volume as (
    
    SELECT
    date_trunc('day', block_time) AS "date", 
    case when token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'::bytea then token_b_symbol else token_a_symbol end as token_traded_against,
    SUM(
        CASE WHEN token_a_address = a.contract_address THEN token_a_amount * a.price    -- Use token A when there's USD price for it                    
        ELSE token_b_amount * b.price                                                   -- Else use token b                             
        END   
        ) AS usd_volume                                                                                
FROM dex."trades" t                                                                             
LEFT JOIN prices a ON date_trunc('minute', block_time) = a.minute AND token_a_address = a.contract_address -- Joining with prices on time and token address for token A
LEFT JOIN prices b ON date_trunc('minute', block_time) = b.minute AND token_b_address = b.contract_address -- Joining with prices on time and token address for token B
WHERE block_time >= now() - interval '30 days'
and(token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'::bytea or token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'::bytea)
GROUP BY 1, 2) select * from volume order by "date", usd_volume desc


/* How much in "other" tokens was BANK token traded for on *all* DEXES */
/* note: BANK token is token_b, 'other' tokens are token_a */
SELECT
    token_a_symbol,
    token_a_amount,
    trader_a,
    token_a_amount_raw,
    usd_amount,
    token_a_address,
    token_b_address,
    project,
    version
FROM dex."trades"
WHERE token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' 

/* Reversal: BANK token is token_a, 'other' tokens are token_b */
SELECT
token_b_symbol,
token_b_amount,
trader_b,
token_b_amount_raw,
usd_amount,
token_b_address,
token_a_address,
project,
version
FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' 

/* Tokens traded against BANK token across DEXes */
/* My version */
WITH temp_table AS (
    SELECT
        block_time,
        token_a_symbol,
        token_b_symbol,
        token_a_amount,
        token_b_amount,
        usd_amount,
        token_b_address,
        token_a_address,
        project,
        version
    FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
) 
SELECT
    DATE_TRUNC('day', block_time) as dt,
    CASE WHEN token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' THEN token_b_symbol ELSE token_a_symbol END AS token_traded_against,
    SUM(usd_amount) AS sum_usd
FROM temp_table
GROUP BY 1,2
ORDER BY dt DESC

/* Total BANK Trade Volume */
WITH temp_table AS (
    SELECT
        block_time,
        token_a_symbol,
        token_b_symbol,
        token_a_amount,
        token_b_amount,
        usd_amount,
        token_b_address,
        token_a_address,
        project,
        version
    FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
), temp_table2 AS (
SELECT
    DATE_TRUNC('day', block_time) as dt,
    CASE WHEN token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' THEN token_b_symbol ELSE token_a_symbol END AS token_traded_against,
    SUM(usd_amount) AS sum_usd
FROM temp_table
GROUP BY 1,2
ORDER BY dt DESC
)
SELECT
    SUM(sum_usd) AS total_volume
FROM temp_table2

/* Total BANK Trade Vol. BY Token PAIR */
/* Pie Chart input */
WITH temp_table AS (
    SELECT
        block_time,
        token_a_symbol,
        token_b_symbol,
        token_a_amount,
        token_b_amount,
        usd_amount,
        token_b_address,
        token_a_address,
        project,
        version
    FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
), temp_table2 AS (
SELECT
    DATE_TRUNC('day', block_time) as dt,
    CASE WHEN token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' THEN token_b_symbol ELSE token_a_symbol END AS token_traded_against,
    SUM(usd_amount) AS sum_usd
FROM temp_table
GROUP BY 1,2
ORDER BY dt DESC
)
SELECT
    SUM(sum_usd) AS total_volume,
    token_traded_against
FROM temp_table2
GROUP by 2
ORDER by token_traded_against DESC

/* Number of Unique Addresses trading BANK (by Trading Pair) */
SELECT
    DATE_TRUNC('day', block_time) AS dt,
    CONCAT(token_a_symbol, token_b_symbol),
    COUNT(DISTINCT(trader_a)) AS unique_addresses,
    project,
    version
FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
GROUP BY 1, 2, 4, 5
ORDER BY dt DESC

/* Total Number of Unique Addresses that traded BANK */
/* 967 as of May 8th */
WITH temp_table AS (
SELECT
    DATE_TRUNC('day', block_time) AS dt,
    CONCAT(token_a_symbol, token_b_symbol),
    COUNT(DISTINCT(trader_a)) AS unique_addresses,
    project,
    version
FROM dex."trades"
WHERE token_a_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198' OR token_b_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
GROUP BY 1, 2, 4, 5
ORDER BY dt DESC
)
SELECT
    SUM(unique_addresses) AS total_unique_addresses
FROM temp_table


/* Top 20 $BANK Holders */
/* Try changing to 2500 */
WITH transfers AS (
    SELECT
    evt_tx_hash AS tx_hash,
    tr."from" AS address,
    -tr.value AS amount
     FROM erc20."ERC20_evt_Transfer" AS tr
     WHERE contract_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
UNION ALL
    SELECT
    evt_tx_hash AS tx_hash,
    tr."to" AS address,
    tr.value AS amount
     FROM erc20."ERC20_evt_Transfer" AS tr 
     WHERE contract_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
),
balances AS (
    SELECT address, sum(amount/1e18) AS balance
    FROM transfers
    WHERE address <> '\x0000000000000000000000000000000000000000'
    GROUP BY 1
    ORDER BY 2 desc
),
balances_top20 AS (
    SELECT address, balance
    FROM balances
    LIMIT 20
),
counts AS (
    SELECT count(address) AS holders, sum(balance) AS holdings FROM balances
),
balances_others AS (
    SELECT address, balance 
    FROM balances 
    WHERE address NOT IN (SELECT address FROM balances_top20)
),
counts_others AS (
    SELECT count(address) AS holders, sum(balance) AS holdings FROM balances_others
),
balances_top21 AS (
    SELECT CONCAT('0x', SUBSTRING(CAST(address AS varchar), 3, 40)) AS address, balance
    FROM balances_top20
UNION ALL
    SELECT 'Others' AS address, holdings AS balance
    FROM counts_others
)
SELECT *
FROM balances_top21