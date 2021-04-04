/* DEX 24 Hours Volume */
SELECT
    SUM(usd_amount)/1e9 AS billion_volume
FROM dex."trades"
WHERE block_time > now() - interval '24 hours'
AND category = 'DEX'


/* note: two categories - DEX & Aggregator */
SELECT
    DISTINCT(category) AS distinct_category
FROM dex."trades"
LIMIT 50



/* DEX 7 Day Volume */
/* note: time interval can change, 24 hours, 7 days, 1 month */

SELECT
    SUM(usd_amount)/1e9 AS billion_volume
FROM dex."trades"
WHERE block_time > now() - interval '7 days'
AND category = 'DEX'

/* Aggregators 7 days Volume */

/* DEX Trailing 24 Hours Growth */

/* DEX Trailing 7 Days Growth */

/* Aggregator share of DEX volume */

/* Ranked DEX by Volume  */

/* Exclude Uniswap V2 - "exchange_contract_address" != '\xf9c1fA7d41bf44ADe1dd08D37CC68f67Ae75bF92' */

/* Ranked DEX by Volume (7-days)  */
/* NOTE: number formatting inside Dune UI */

SELECT
    project,
    SUM(usd_amount) AS "7-Day Volume"
FROM dex."trades"
WHERE block_time > now() - interval '7 days'
AND category = 'DEX'
AND "exchange_contract_address" != '\xf9c1fA7d41bf44ADe1dd08D37CC68f67Ae75bF92' 
GROUP BY project
ORDER BY "7-Day Volume" DESC
LIMIT 20


/* Market Share DEX by Volume */

/* Aggregator share of DEX volume */

/* Daily DEX Volume */

/* Number of traders last 7 Days */

/* Ranked Aggregator by Volume */

/*** WEEKLY  ***/

/* Weekly DEX Volume */

/* Market Share Weekly DEX Volume */

/*** MONTHLY  ***/

/* Monthly DEX Volume By Project */

/* Monthly DEX Volume grouped by year */

/* 12 Months DEX volume */

/* 30 days DEX volume */

/* Counter: Number of DEX Traders */

