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
