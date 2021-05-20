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
    COUNT(CASE WHEN balance >= 100000000 THEN 1 END) AS hundred_millions,
    COUNT(CASE WHEN balance >= 1000000 AND balance < 100000000 THEN 1 END) AS millions,
    COUNT(CASE WHEN balance >= 500000 AND balance < 1000000 THEN 1 END) AS five_hundrend_k,
    COUNT(CASE WHEN balance >= 150000 AND balance < 500000 THEN 1 END) AS one_fifty_k,
    COUNT(CASE WHEN balance >= 35000 AND balance < 150000 THEN 1 END) AS thirty_five_k,
    COUNT(CASE WHEN balance >= 10000 AND balance < 35000 THEN 1 END) AS ten_k,
    COUNT(CASE WHEN balance >= 1 AND balance < 10000 THEN 1 END) AS less_ten_k
FROM temp_table2
WHERE balance >= 1


/* CUMMULATIVE SUM of BANK Holders */
/* Does not quite provide historical snapshots */
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
    evt_block_time,
    address,
    SUM(amount/10^18) AS balance
FROM temp_table tr
LEFT JOIN erc20.tokens tok ON tr.contract_address = tok.contract_address
GROUP BY 1, 2
ORDER BY 3 DESC
), temp_table3 AS (
SELECT
    DATE_TRUNC('day', evt_block_time) AS dt,
    COUNT(address) AS num_bank_holders
FROM temp_table2
WHERE balance > 0
GROUP BY dt
ORDER BY dt DESC
)
SELECT
    dt,
    num_bank_holders,
    SUM(num_bank_holders) OVER (ORDER BY dt)
FROM temp_table3
ORDER BY dt DESC

/* Holders with more than ONE $BANK */
/* More reflective when adding categories of BANK holders together */
/* meaningful difference between > 0 & > 1 $BANK */

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
), temp_table3 AS (
SELECT
    address,
    balance,
    (balance / 1000000000) * 100 AS percentage
FROM temp_table2
WHERE balance > 0
) 
SELECT
    address,
    balance,
    percentage
FROM temp_table3
WHERE balance >= 1

/* Bank Holder Categories */
/* Successful Pivot Longer */
/* Successful insert Name column */

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
), temp_table3 AS (
SELECT
    COUNT(CASE WHEN balance >= 100000000 THEN 1 END) AS hundred_millions,
    COUNT(CASE WHEN balance >= 1000000 AND balance < 100000000 THEN 1 END) AS millions,
    COUNT(CASE WHEN balance >= 500000 AND balance < 1000000 THEN 1 END) AS five_hundred_k,
    COUNT(CASE WHEN balance >= 150000 AND balance < 500000 THEN 1 END) AS one_fifty_k,
    COUNT(CASE WHEN balance >= 35000 AND balance < 150000 THEN 1 END) AS thirty_five_k,
    COUNT(CASE WHEN balance >= 10000 AND balance < 35000 THEN 1 END) AS ten_k,
    COUNT(CASE WHEN balance >= 1 AND balance < 10000 THEN 1 END) AS less_ten_k
FROM temp_table2
WHERE balance >= 1
), CTE AS (
SELECT '100M+' AS Name, hundred_millions AS Value
FROM temp_table3
UNION ALL
SELECT '1M+' AS Name, millions AS Value
FROM temp_table3
UNION ALL
SELECT '500K - 1M' AS Name, five_hundred_k AS Value
FROM temp_table3
UNION ALL
SELECT '150K - 500K' AS Name, one_fifty_k AS Value
FROM temp_table3
UNION ALL
SELECT '35K - 150K' AS Name, thirty_five_k AS Value
FROM temp_table3
UNION ALL
SELECT '10K - 35K' AS Name, ten_k AS Value
FROM temp_table3
UNION ALL
SELECT '< 10K' AS Name, less_ten_k AS Value
FROM temp_table3
)
SELECT Name, Value
FROM CTE

