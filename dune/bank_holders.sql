/* $BANK Token HOlders */
WITH temp_table AS (
SELECT 
    evt_block_time,
    tr."from" AS address,
    -tr.value AS amount,
    contract_address
FROM erc20."ERC20_evt_Transfer" tr
WHERE contract_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'

UNION ALL

SELECT
    evt_block_time,
    tr."to" AS address,
    tr.value AS amount,
    contract_address
FROM erc20."ERC20_evt_Transfer" tr
WHERE contract_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
)
SELECT
    address,
    SUM(amount/10^18) AS balance
FROM temp_table tr
LEFT JOIN erc20.tokens tok ON tr.contract_address = tok.contract_address
GROUP BY 1
ORDER BY 2 DESC


/* $BANK Token Holders v2 */
/* incl Percentage */
/* filter out 0 balances - or people who sold */
WITH temp_table AS (
SELECT 
    evt_block_time,
    tr."from" AS address,
    -tr.value AS amount,
    contract_address
FROM erc20."ERC20_evt_Transfer" tr
WHERE contract_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'

UNION ALL

SELECT
    evt_block_time,
    tr."to" AS address,
    tr.value AS amount,
    contract_address
FROM erc20."ERC20_evt_Transfer" tr
WHERE contract_address = '\x2d94aa3e47d9d5024503ca8491fce9a2fb4da198'
), temp_table2 AS (
SELECT
    address,
    SUM(amount/10^18) AS balance
FROM temp_table tr
LEFT JOIN erc20.tokens tok ON tr.contract_address = tok.contract_address
GROUP BY 1
ORDER BY 2 DESC
)
SELECT
    address,
    balance,
    (balance / 1000000000) * 100 AS percentage
FROM temp_table2
WHERE balance > 0

