/* Number of Blocks, per day */


/* Total Number of Blocks */

/* num_blocks = 12107128 */
SELECT 
DATE_TRUNC('day', time) AS dt
COUNT(*) AS num_blocks
FROM ethereum."blocks"
LIMIT 10

/* Number of Blocks PER DAY */
/* earliest: 2015-07-30 - 6911 */
/* latest: 2021-03-23 - 6505 */
SELECT 
DATE_TRUNC('day', time) AS dt,
COUNT(*) AS num_blocks
FROM ethereum."blocks"
WHERE time > now() - interval '10 days'
GROUP BY 1
LIMIT 10

SELECT 
DATE_TRUNC('day', time) AS dt,
COUNT(*) AS num_blocks
FROM ethereum."blocks"
GROUP BY 1
LIMIT 10


/* Difficulty */

/* Difficulty initial 10 transactions 2015 */
/* July 30th 2015: 17,171,480,576 */
SELECT difficulty, time
FROM ethereum."blocks"
LIMIT 10

/* Difficulty most recent transactions 2021 */
/* March 15th 2021: 5,554,161,262,667,699  */
SELECT difficulty, time
FROM ethereum."blocks"
WHERE time > now() - interval '10 days'
LIMIT 10