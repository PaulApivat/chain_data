/* Initial BAT Token query from ERC20_evt_Transfer */
SELECT "from", "to", "value", "evt_block_time"
FROM erc20."ERC20_evt_Transfer"
WHERE contract_address='\x0d8775f648430679a709e98d2b0cb6250d2887ef' --BAt Token Address
LIMIT 10

/* Decimal Places for Value */
SELECT "from", "to", "value" /10^("decimals") as "value"
FROM "erc20"."ERC20_evt_Transfer", "erc20"."tokens"
WHERE "ERC20_evt_Transfer".contract_address='\x0d8775f648430679a709e98d2b0cb6250d2887ef' --BAt Token Address
AND "tokens".contract_address="ERC20_evt_Transfer".contract_address
-- ORDER BY "evt_block_number" DESC
LIMIT 10

/* VALUE TRANSFER of BAT Token Since 2017 */
SELECT 
SUM("value" /10^("decimals")) AS "value", 
DATE_TRUNC('day', evt_block_time) AS dt
FROM "erc20"."ERC20_evt_Transfer", "erc20"."tokens"
WHERE "ERC20_evt_Transfer".contract_address='\x0d8775f648430679a709e98d2b0cb6250d2887ef' --BAt Token Address
AND "tokens".contract_address="ERC20_evt_Transfer".contract_address
-- ORDER BY "evt_block_number" DESC
GROUP BY dt