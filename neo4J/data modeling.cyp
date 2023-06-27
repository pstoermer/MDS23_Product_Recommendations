# Loads a CSV file containing user and product data
LOAD CSV WITH HEADERS FROM 'file:///test2.csv' AS row

# Creates or updates corresponding nodes in the database
MERGE (u:User {userId: row.UserId})
MERGE (p:Product {productId: row.ProductId})
  ON CREATE SET p.productType = row.ProductType
  ON CREATE SET p.url = row.URL

# Establishes relationships between users and products based on ratings
MERGE (u)-[rated:RATED]->(p)
  ON CREATE SET rated.rating = toFloat(row.Rating)
  ON CREATE SET rated.timestamp = toFloat(row.Timestamp)
