/* Number of Blocks, per day */


/* Total Number of Blocks */

/* num_blocks = 12107128 */
SELECT 
DATE_TRUNC('day', time) AS dt
COUNT(*) AS num_blocks
FROM ethereum."blocks"
LIMIT 10

/* VISUALIZE Number of Blocks PER DAY */
/* earliest: 2015-07-30 - 6911 */
/* latest: 2021-03-23 - 6505 */

SELECT 
DATE_TRUNC('day', time) AS dt,
COUNT(*) AS num_blocks
FROM ethereum."blocks"
GROUP BY 1
OFFSET 1


/* VISUALIZE AVERAGE DIFFICULTY */

SELECT 
DATE_TRUNC('day', time) AS dt,
AVG(difficulty) AS avg_difficulty
FROM ethereum."blocks"
GROUP BY 1
OFFSET 1


/* VISUALIZE UNIQUE MINERS Per Day */

SELECT
DATE_TRUNC('day', time) AS dt,
COUNT(DISTINCT(miner)) AS unique_miner
FROM ethereum."blocks"
GROUP BY 1
OFFSET 1


/* GAS */

/* VISUALIZE TOTAL GAS USAGE */
/* Daily Gas Fees (gwei) on Ethereum */
SELECT 
SUM(gas_used) AS gas_sum,
DATE_TRUNC('day', time) AS dt
FROM ethereum."blocks"
GROUP BY dt
OFFSET 1

/* VISUALIZE Block Gas Limit */

SELECT 
SUM(gas_limit) AS sum_gas_limit,
DATE_TRUNC('day', time) AS dt
FROM ethereum."blocks"
GROUP BY dt
OFFSET 1





/* TRANSACTIONS */

/* Total transactions in the last 10 days */
SELECT 
DATE_TRUNC('day',block_time) AS dt
    , COUNT(*) AS num_tx
FROM ethereum."transactions"
WHERE block_time >= (DATE_TRUNC('day',CURRENT_TIMESTAMP) - '10 days'::INTERVAL)
GROUP BY dt

/* Total Daily Transactions on Ethereum */
SELECT 
DATE_TRUNC('day',block_time) AS dt
    , COUNT(*) AS num_tx
FROM ethereum."transactions"
GROUP BY dt
OFFSET 1

/* TOTAL ACCOUNTS */
/* Need to join with "blocks" to use time */

SELECT 
COUNT(address) AS num_addresses
FROM ethereum."traces"
LIMIT 10

/* inner join "blocks" and "traces" */
SELECT address, block_hash, time
FROM ethereum."traces"
INNER JOIN ethereum."blocks" ON block_hash=hash
LIMIT 10

