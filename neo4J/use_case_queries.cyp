

MATCH (user:User)-[rated:RATED]->(product:Product)
WHERE user.userId <> 'ALNFHVS3SC4FV'
  AND rated.rating > 4.5
  AND NOT EXISTS {
    MATCH (user2:User)-[rated2:RATED]->(product)
    WHERE user2.userId = 'ALNFHVS3SC4FV'
  }
RETURN DISTINCT product.productId, product.productType, product.URL;


MATCH (p:Product) 
RETURN p, COUNT(*) AS purchaseCount 
ORDER BY purchaseCount DESC


MATCH (u:User {userId: 'ALNFHVS3SC4FV'})-[:RATED]->(p:Product) 
RETURN p    


MATCH (p:Product)
WHERE p.productId <> 'B00J9E8MPS' AND (:User)-[:RATED {rating: 5}]->(p)
WITH COLLECT(p.productId) AS ratedProducts
MATCH (otherUser:User)-[:RATED {rating: 5}]->(otherProduct:Product)
WHERE otherUser.userId <> 'A33C1XXJYLFW0X' AND otherProduct.productId IN ratedProducts
RETURN DISTINCT otherProduct.productId, otherProduct.productType, otherProduct.URL


MATCH (a:Product {productId: 'B0043OYFKU'})
    WITH a.productType AS productType
MATCH (p:Product)<-[r:RATED]-()
    WHERE p.productType = productType AND p.productId <> 'B0043OYFKU'
        AND r.rating > 4.0
RETURN DISTINCT p.productId, p.productType, p.url


MATCH (:Product {productId: 'B0043OYFKU'})<-[:RATED]-(u:User)-[:RATED]->(p2:Product)
WHERE NOT p2.productId = 'B0043OYFKU'
RETURN u.userId, p2.productId, p2.productType, p2.url


MATCH (p:Product)<-[r:RATED]-()
WITH p, AVG(r.rating) AS AverageRating, COUNT(r) AS RatingCount
WHERE RatingCount >= 10
RETURN p.productId, p.productType, p.url, AverageRating
ORDER BY AverageRating DESC
