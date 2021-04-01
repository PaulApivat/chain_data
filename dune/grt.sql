/* RESOURCE */
https://etherscan.io/token/0xc944e90c64b2c07662a292be6244bdf05cda44a7

/* Query Contract Address / Token Symbol */
SELECT * FROM erc20."tokens"
WHERE symbol='GRT'
LIMIT 10

SELECT * FROM erc20."tokens"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
LIMIT 10

/* Token TRANSFER AMOUNT GRT */
SELECT 
SUM("value"/10^18) AS "value",
DATE_TRUNC('day', evt_block_time) AS dt
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\xc944e90c64b2c07662a292be6244bdf05cda44a7'
GROUP BY dt



