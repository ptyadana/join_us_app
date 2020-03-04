CREATE TABLE users(
	email VARCHAR(255) UNIQUE PRIMARY KEY,
	created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(email)
VALUES('sweety@noemail.com');

/* ------------- exercises ------------- */

/*Find Earliest Date A User Joined
+---------------+
| earliest_date |
+---------------+
| May 2nd 2016  |
+---------------+
*/
SELECT DATE_FORMAT(created_at,'%M %D %Y') AS earliest_date FROM users ORDER BY created_at LIMIT 1;



/*Find Email Of The First (Earliest)User

+-----------------------------+---------------------+
| email                       | created_at          |
+-----------------------------+---------------------+
| Friedrich_Kulas@hotmail.com | 2016-05-02 20:28:18 |
+-----------------------------+---------------------+*/

SELECT * FROM users ORDER BY created_at LIMIT 1;


/*Users According To The Month They Joined
+-----------+-------+
| month     | count |
+-----------+-------+
| November  |    51 |
| January   |    49 |
| May       |    48 |
| December  |    47 |
| July      |    46 |
| June      |    43 |
| April     |    41 |
| October   |    41 |
| September |    40 |
| March     |    40 |
| August    |    40 |
| February  |    32 |
+-----------+-------+
*/
SELECT DATE_FORMAT(created_at,'%M') AS month, COUNT(*) AS count
FROM users
GROUP BY month
ORDER BY 2 DESC;


/*Count Number of Users With Yahoo Emails
+-------------+
| yahoo_users |
+-------------+
|         166 |
+-------------+
*/
SELECT COUNT(*) AS yahoo_users FROM users
WHERE email LIKE '%@yahoo.com%';


/*Calculate Total Number of Users for Each Email Host
+----------+-------------+
| provider | total_users |
+----------+-------------+
| gmail    |         190 |
| yahoo    |         166 |
| hotmail  |         159 |
| other    |           3 |
+----------+-------------+
*/
SELECT RIGHT(email,LENGTH(email)-INSTR(email,"@")) AS provider, COUNT(*) AS total_users
FROM users
GROUP BY provider;


/* another version*/
SELECT 
	CASE
		WHEN email LIKE '%gmail.com%' THEN 'gmail'
		WHEN email LIKE '%yahoo.com%' THEN 'yahoo'
		WHEN email LIKE '%hotmail.com%' THEN 'hotmail'
		ELSE 'other'
	END AS provider
	,COUNT(*) AS total_users
FROM users
GROUP BY provider
ORDER BY total_users DESC;

