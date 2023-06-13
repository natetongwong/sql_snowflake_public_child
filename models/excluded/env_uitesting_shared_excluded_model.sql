WITH raw_customers AS (

  SELECT * 
  
  FROM {{ ref('raw_customers')}}

)

SELECT *

FROM raw_customers
