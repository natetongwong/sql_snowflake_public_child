WITH env_uitesting_shared_mid_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_mid_model_1')}}

),

Reformat_1 AS (

  SELECT * 
  
  FROM env_uitesting_shared_mid_model_1 AS in0

)

SELECT *

FROM Reformat_1
