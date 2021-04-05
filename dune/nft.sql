/* Super Rare v2: NFT Artists Onboarding by Month */
SELECT 
   COUNT(DISTINCT("to")) AS artist_addr,
   DATE_TRUNC('month', evt_block_time) AS month_created
FROM superrare."SuperRare_v2_evt_Transfer"
WHERE "from" = '\x0000000000000000000000000000000000000000'
AND EXTRACT (year from evt_block_time) >= 2018
GROUP BY month_created
LIMIT 50

/* Super Rare v1: NFT Artists Onboarding by Month */
SELECT 
   COUNT(DISTINCT("_to")) AS artist_addr,
   DATE_TRUNC('month', evt_block_time) AS month_created
FROM superrare."SuperRare_evt_Transfer"
WHERE "_from" = '\x0000000000000000000000000000000000000000'
AND EXTRACT (year from evt_block_time) >= 2018
GROUP BY month_created
LIMIT 50

/* Async Art v2: NFT Artist Onboarding */
SELECT 
   COUNT(DISTINCT("to")) AS artist_addr,
   DATE_TRUNC('month', evt_block_time) AS month_created
FROM async_art_v2."AsyncArtwork_v2_evt_Transfer"
WHERE "from" = '\x0000000000000000000000000000000000000000'
AND EXTRACT (year from evt_block_time) >= 2018
GROUP BY month_created
LIMIT 50

/* Async Art v1 NFT Artist Onboarding */
SELECT 
   COUNT(DISTINCT("to")) AS artist_addr,
   DATE_TRUNC('month', evt_block_time) AS month_created
FROM async."AsyncArtwork_evt_Transfer"
WHERE "from" = '\x0000000000000000000000000000000000000000'
AND EXTRACT (year from evt_block_time) >= 2018
GROUP BY month_created
LIMIT 50
