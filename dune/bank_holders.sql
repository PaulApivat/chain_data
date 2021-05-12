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

/* Also */
/* WHERE balance > 34999 */
/* WHERE balance > 149999 */

/* Uniswap BANK/ETH LP Token Holders */
/* 21 current holders */
WITH temp_table AS (
SELECT 
    evt_block_time,
    tr."from" AS address,
    -tr.value AS amount,
    contract_address
FROM erc20."ERC20_evt_Transfer" tr
WHERE contract_address = '\x59c1349bc6f28a427e78ddb6130ec669c2f39b48'

UNION ALL

SELECT
    evt_block_time,
    tr."to" AS address,
    tr.value AS amount,
    contract_address
FROM erc20."ERC20_evt_Transfer" tr
WHERE contract_address = '\x59c1349bc6f28a427e78ddb6130ec669c2f39b48'
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
    (balance / 3491) * 100 AS percentage
FROM temp_table2
WHERE balance > 0



/* Bank Holders */
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
    balance
FROM temp_table2
WHERE balance > 0

/* BINNING */
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
    COUNT(CASE WHEN balance >= 100000001 THEN 1 END) AS hundred_millions,
    COUNT(CASE WHEN balance >= 1000001 AND balance < 100000000 THEN 1 END) AS millions,
    COUNT(CASE WHEN balance >= 500001 AND balance < 1000000 THEN 1 END) AS five_hundrend_k,
    COUNT(CASE WHEN balance >= 150001 AND balance < 500000 THEN 1 END) AS one_fifty_k,
    COUNT(CASE WHEN balance >= 35001 AND balance < 150000 THEN 1 END) AS thirty_five_k,
    COUNT(CASE WHEN balance < 35000 THEN 1 END) AS less_thirty_five_k
FROM temp_table2
WHERE balance > 0