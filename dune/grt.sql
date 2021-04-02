/* RESOURCE */
https://etherscan.io/token/0xc944e90c64b2c07662a292be6244bdf05cda44a7

/* Query Contract Address / Token Symbol - Time Series */
SELECT * FROM erc20."tokens"
WHERE symbol='GRT'
LIMIT 10

SELECT * FROM erc20."tokens"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
LIMIT 10

/* Token TRANSFER AMOUNT GRT - Time Series */
SELECT 
SUM("value"/10^18) AS "value",
DATE_TRUNC('day', evt_block_time) AS dt
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY dt

/* Token TRANSFER COUNT GRT - Time Series */
SELECT 
COUNT(contract_address) AS contract_address_count,
DATE_TRUNC('day', evt_block_time) AS dt
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY dt

/* Unique Receivers GRT Token - Time Series */
SELECT 
COUNT(DISTINCT("to")) AS unique_receivers,
DATE_TRUNC('day', evt_block_time) AS dt
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY dt

/* Unique Senders GRT Token - Time Series */
SELECT 
COUNT(DISTINCT("from")) AS unique_senders,
DATE_TRUNC('day', evt_block_time) AS dt
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY dt

/* Unique Owner, Total Value Held */
SELECT 
COUNT(DISTINCT(owner)) AS unique_owner, 
SUM("value") AS sum_value, 
DATE_TRUNC('day', evt_block_time) AS dt
FROM erc20."ERC20_evt_Approval"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY dt

/* Top 100 Unique Owner by Total Value (GRT Token) */
SELECT 
DISTINCT(owner) as distinct_owner,
SUM("value"/10^18) AS sum_value
FROM erc20."ERC20_evt_Approval"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY distinct_owner
ORDER BY sum_value DESC
LIMIT 100


/* Top 100 Owner & Spender by Total Value (GRT Token) */
SELECT 
owner,
SUM("value"/10^18) AS sum_value
FROM erc20."ERC20_evt_Approval"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY owner
ORDER BY sum_value DESC
LIMIT 100


SELECT 
spender,
SUM("value"/10^18) AS sum_value
FROM erc20."ERC20_evt_Approval"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY spender
ORDER BY sum_value DESC
LIMIT 100

/* Top 100 Token Holders(?) of GRT Token */
SELECT 
"to" AS holder,
SUM("value"/10^18) AS sum_value
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY holder
ORDER BY sum_value DESC
LIMIT 100


/* If unsure DISTINCT(owner) makes a different do a comparison count */
/* Makes a huge difference */

/* Number of Token Owners 120555 */
SELECT 
COUNT(owner)
FROM erc20."ERC20_evt_Approval"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
LIMIT 10

/* Number of Unique Token Owners 25340 */
SELECT 
COUNT(DISTINCT(owner))
FROM erc20."ERC20_evt_Approval"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
LIMIT 10