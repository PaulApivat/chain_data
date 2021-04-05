
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

/* ADD Super Rare v1 + v2 Apr 2018 - Mar 2021 */
/* 5415 total NFTs minted */

SELECT 
    SUM(artist_addr) AS total_artists, 
    month_created
FROM
(    
-------------------------SuperRare v1 ------------------------
    SELECT 
        COUNT(DISTINCT("_to")) AS artist_addr,
        DATE_TRUNC('month', evt_block_time) AS month_created
    FROM superrare."SuperRare_evt_Transfer"
    WHERE "_from" = '\x0000000000000000000000000000000000000000'
    AND EXTRACT (year from evt_block_time) >= 2018
    GROUP BY month_created


    UNION ALL
    
-------------------------SuperRare v2 ------------------------

    SELECT 
        COUNT(DISTINCT("to")) AS artist_addr,
        DATE_TRUNC('month', evt_block_time) AS month_created
    FROM superrare."SuperRare_v2_evt_Transfer"
    WHERE "from" = '\x0000000000000000000000000000000000000000'
    AND EXTRACT (year from evt_block_time) >= 2018
    GROUP BY month_created

)A /* alias */
GROUP BY month_created
ORDER BY month_created DESC




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

/* ADD Async Art v1 + v2 */
/* 366 NFTs minted */

SELECT 
    SUM(artist_addr) AS total_artists,
    month_created
FROM
(    
-------------------------AsyncArt v1 ------------------------
    SELECT 
        COUNT(DISTINCT("to")) AS artist_addr,
        DATE_TRUNC('month', evt_block_time) AS month_created
    FROM async."AsyncArtwork_evt_Transfer"
    WHERE "from" = '\x0000000000000000000000000000000000000000'
    AND EXTRACT (year from evt_block_time) >= 2018
    GROUP BY month_created


    UNION ALL
    
-------------------------AsyncArt v2 ------------------------

    SELECT 
        COUNT(DISTINCT("to")) AS artist_addr,
        DATE_TRUNC('month', evt_block_time) AS month_created
    FROM async_art_v2."AsyncArtwork_v2_evt_Transfer" 
    WHERE "from" = '\x0000000000000000000000000000000000000000'
    AND EXTRACT (year from evt_block_time) >= 2018
    GROUP BY month_created

)A /* alias */
GROUP BY month_created
ORDER BY month_created DESC







/* Known Origin: NFTs per month */ 
/* 978 NFTs minted to date */

SELECT 
   COUNT(DISTINCT("_creator")) AS artist_addr,
   DATE_TRUNC('month', evt_block_time) AS month_created
FROM knownorigin."SelfServiceEditionCurationV4_evt_SelfServiceEditionCreated"
WHERE EXTRACT (year from evt_block_time) >= 2018
GROUP BY month_created
LIMIT 50

/* Rarible: NFTs minted per month */ 
/* 37169 NFTs minted to date */

SELECT 
   COUNT(DISTINCT("_to")) AS artist_addr,
   DATE_TRUNC('month', evt_block_time) AS month_created
FROM rarible_v1."RaribleToken_v1_evt_TransferSingle" 
WHERE "_from" = '\x0000000000000000000000000000000000000000'
AND EXTRACT (year from evt_block_time) >= 2018
GROUP BY month_created
LIMIT 50

/* Sum total NFTs minted */
SELECT 
   COUNT(DISTINCT("_to")) AS artist_addr
   /*DATE_TRUNC('month', evt_block_time) AS month_created*/
FROM rarible_v1."RaribleToken_v1_evt_TransferSingle" 
WHERE "_from" = '\x0000000000000000000000000000000000000000'
AND EXTRACT (year from evt_block_time) >= 2018
/*GROUP BY month_created
LIMIT 50*/