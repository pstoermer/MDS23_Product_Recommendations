-- Use Case Queries
-- 1 Create personalized recommendations for a specific user based on similar purchases from another user
SELECT DISTINCT p.ProductId, p.ProductType, p.URL
FROM Ratings r
JOIN Products p ON r.ProductID = p.ProductID
WHERE r.UserID <> 'ALNFHVS3SC4FV' -- Exclude the defined user
AND r.Rating > 4.5
AND r.ProductID NOT IN (
    SELECT ProductID
    FROM Ratings
    WHERE UserID = 'ALNFHVS3SC4FV'
    )
GROUP BY p.ProductID, p.ProductType, p.URL;

-- 2 Most rated products
SELECT p.ProductId, p.ProductType, p.URL, COUNT(r.Rating) AS RatingCount
FROM Products p
JOIN Ratings r ON p.ProductId = r.ProductId
GROUP BY p.ProductId, p.ProductType, p.URL
ORDER BY RatingCount DESC;
--FETCH FIRST 300 ROWS ONLY;

-- 3 Show all purchased products of a specific user
SELECT p.ProductId, p.ProductType, p.URL
FROM Products p
JOIN Ratings r ON p.ProductId = r.ProductId
WHERE r.UserId = 'ALNFHVS3SC4FV';

SELECT u.UserId FROM Users u;
-- 4  Find products that were highly rated by other users who rated Product A with a 5
SELECT DISTINCT p.ProductId, p.ProductType, p.URL
FROM Products p
JOIN Ratings r ON p.ProductId = r.ProductId
WHERE r.UserId <> 'A33C1XXJYLFW0X'
AND r.ProductId <> 'B00J9E8MPS'
AND r.Rating = 5
AND EXISTS (
SELECT 1
FROM Ratings r2
WHERE r2.ProductId = 'B00J9E8MPS'
AND r2.Rating = 5
AND r2.UserId <> 'A33C1XXJYLFW0X'
);


-- 5 Find products of the same category as Product A with high ratings
SELECT p.ProductId, p.ProductType, p.URL
FROM Products p
WHERE p.ProductType = (SELECT ProductType FROM Products WHERE ProductId = 'B0043OYFKU')
  AND p.ProductId <> 'B0043OYFKU'
  AND p.ProductId IN (
    SELECT r.ProductId
    FROM Ratings r
    WHERE r.ProductId = p.ProductId
      AND r.Rating > 4.0
  );

-- 6 Find all customers who have rated a given product and the other products they have rated
SELECT DISTINCT u.UserId, p2.ProductId, p2.ProductType, p2.URL
FROM Users u
JOIN Ratings r1 ON u.UserId = r1.UserId
JOIN Products p1 ON r1.ProductId = p1.ProductId
JOIN Ratings r2 ON u.UserId = r2.UserId
JOIN Products p2 ON r2.ProductId = p2.ProductId
WHERE p1.ProductId = 'B0043OYFKU'
AND p2.ProductId <> 'B0043OYFKU';



-- 7 Sort Products by Rating
SELECT p.ProductId, p.ProductType, p.URL, AVG(r.Rating) AS AverageRating
FROM Ratings r
JOIN Products p ON r.ProductId = p.ProductId
GROUP BY p.ProductId, p.ProductType, p.URL
HAVING COUNT(r.Rating) >= 10
ORDER BY AverageRating DESC;



