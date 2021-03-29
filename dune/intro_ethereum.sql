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


/* VISUALIZE AVERAGE Difficulty */

SELECT 
DATE_TRUNC('day', time) AS dt,
AVG(difficulty) AS avg_difficulty
FROM ethereum."blocks"
GROUP BY 1
OFFSET 1


/* MINERS */

/* Total Number of Distinct Miners on Ethereum */
/* 5398 */
SELECT COUNT(DISTINCT(miner))
FROM ethereum."blocks"
LIMIT 10

/* Line or Area chart of Number of Unique Miners PER Day */
/* Truncate Date Before Group By */
SELECT COUNT(DISTINCT(miner)) AS num_miner, DATE_TRUNC('day', time) AS dt
FROM ethereum."blocks"
WHERE time > now() - interval '10 days'
GROUP BY dt
LIMIT 10

/* Line Chart */
/* Number of Distinct Miners PER DAY since beginnning */
/* omit first row */
SELECT 
COUNT(DISTINCT(miner)) AS num_miner, 
DATE_TRUNC('day', time) AS dt
FROM ethereum."blocks"
GROUP BY dt
OFFSET 1

/* GAS */

/* Area Chart */
/* Daily Gas Fees (gwei) on Ethereum */
SELECT 
SUM(gas_used) AS gas_sum,
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
