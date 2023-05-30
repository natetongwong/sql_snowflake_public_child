{{
  config({    
    "materialized": "table"
  })
}}

WITH CATALOG_SALES AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL', 'CATALOG_SALES') }}

),

DATE_DIM AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL', 'DATE_DIM') }}

),

CALL_CENTER AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL', 'CALL_CENTER') }}

),

SQLStatement_3 AS (

  SELECT 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    sum(ss_ext_sales_price) AS itemrevenue,
    sum(ss_ext_sales_price) * 100 / sum(sum(ss_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
  
  FROM store_sales, item, date_dim
  
  WHERE ss_item_sk = i_item_sk and i_category IN ('Women', 'Electronics', 'Shoes') and ss_sold_date_sk = d_date_sk and d_date BETWEEN CAST('2002-05-27' AS date) and dateadd(DAY, 30, to_date('2002-05-27'))
  
  GROUP BY 
    i_item_id, i_item_desc, i_category, i_class, i_current_price
  
  ORDER BY i_category, i_class, i_item_id, i_item_desc, revenueratio

),

SHIP_MODE AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL', 'SHIP_MODE') }}

),

WAREHOUSE AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL', 'WAREHOUSE') }}

),

SQLStatement_0 AS (

  SELECT 
    substr(w_warehouse_name, 1, 20),
    sm_type,
    cc_name,
    sum(CASE
      WHEN (cs_ship_date_sk - cs_sold_date_sk <= 30)
        THEN 1
      ELSE 0
    END) AS "30 days",
    sum(
      CASE
        WHEN (cs_ship_date_sk - cs_sold_date_sk > 30) and
         (cs_ship_date_sk - cs_sold_date_sk <= 60)
          THEN 1
        ELSE 0
      END) AS "31-60 days",
    sum(
      CASE
        WHEN (cs_ship_date_sk - cs_sold_date_sk > 60) and
         (cs_ship_date_sk - cs_sold_date_sk <= 90)
          THEN 1
        ELSE 0
      END) AS "61-90 days",
    sum(
      CASE
        WHEN (cs_ship_date_sk - cs_sold_date_sk > 90) and
         (cs_ship_date_sk - cs_sold_date_sk <= 120)
          THEN 1
        ELSE 0
      END) AS "91-120 days",
    sum(CASE
      WHEN (cs_ship_date_sk - cs_sold_date_sk > 120)
        THEN 1
      ELSE 0
    END) AS ">120 days"
  
  FROM CATALOG_SALES, WAREHOUSE, SHIP_MODE, CALL_CENTER, DATE_DIM
  
  WHERE d_month_seq BETWEEN 1200 and 1200 + 11 and cs_ship_date_sk = d_date_sk and cs_warehouse_sk = w_warehouse_sk and cs_ship_mode_sk = sm_ship_mode_sk and cs_call_center_sk = cc_call_center_sk
  
  GROUP BY 
    substr(w_warehouse_name, 1, 20), sm_type, cc_name
  
  ORDER BY substr(w_warehouse_name, 1, 20), sm_type, cc_name
  
  LIMIT 100

),

Limit_1 AS (

  SELECT * 
  
  FROM SQLStatement_0 AS in0
  
  LIMIT 10

),

Join_1 AS (

  SELECT 
    in1.I_ITEM_ID AS I_ITEM_ID,
    in1.I_ITEM_DESC AS I_ITEM_DESC,
    in1.I_CATEGORY AS I_CATEGORY,
    in1.I_CLASS AS I_CLASS,
    in1.I_CURRENT_PRICE AS I_CURRENT_PRICE,
    in1.ITEMREVENUE AS ITEMREVENUE,
    in1.REVENUERATIO AS REVENUERATIO,
    in0.SM_TYPE AS SM_TYPE,
    in0.CC_NAME AS CC_NAME
  
  FROM Limit_1 AS in0
  INNER JOIN SQLStatement_3 AS in1
     ON in0.SM_TYPE != in1.I_ITEM_DESC

),

SQLStatement_1 AS (

  SELECT 
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    sum(ss_ext_sales_price) AS itemrevenue,
    sum(ss_ext_sales_price) * 100 / sum(sum(ss_ext_sales_price)) OVER (PARTITION BY i_class) AS revenueratio
  
  FROM store_sales, item, date_dim
  
  WHERE ss_item_sk = i_item_sk and i_category IN ('Women', 'Electronics', 'Shoes') and ss_sold_date_sk = d_date_sk and d_date BETWEEN CAST('2002-05-27' AS date) and dateadd(DAY, 30, to_date('2002-05-27'))
  
  GROUP BY 
    i_item_id, i_item_desc, i_category, i_class, i_current_price
  
  ORDER BY i_category, i_class, i_item_id, i_item_desc, revenueratio

),

SQLStatement_2 AS (

  SELECT 
    s_store_name,
    sum(ss_net_profit)
  
  FROM store_sales, date_dim, store, (
    SELECT ca_zip
    
    FROM (
      SELECT substr(ca_zip, 1, 5) AS ca_zip
      
      FROM customer_address
      
      WHERE substr(ca_zip, 1, 5) IN 
      (  '10338',
        '56623',
        '51423',
        '26456',
        '19500',
        '65832',
        '17178',
        '68879',
        '49935',
        '49849',
        '93956',
        '71765',
        '45100',
        '50587',
        '68389',
        '41899',
        '98316',
        '56217',
        '94686',
        '59350',
        '32857',
        '14925',
        '31266',
        '37817',
        '27519',
        '20787',
        '26967',
        '49045',
        '39397',
        '32010',
        '23144',
        '53580',
        '15491',
        '74151',
        '18442',
        '51916',
        '17730',
        '22824',
        '28290',
        '21657',
        '45460',
        '39386',
        '21133',
        '35017',
        '19894',
        '21759',
        '79293',
        '86733',
        '76777',
        '41688',
        '13810',
        '49053',
        '17992',
        '13395',
        '19869',
        '40785',
        '63897',
        '65049',
        '27388',
        '94701',
        '41482',
        '97923',
        '23951',
        '88284',
        '61718',
        '94317',
        '72294',
        '63544',
        '31306',
        '41242',
        '28830',
        '75535',
        '86189',
        '88177',
        '16147',
        '12902',
        '48271',
        '54036',
        '20936',
        '27802',
        '96741',
        '70286',
        '75710',
        '16034',
        '90285',
        '22058',
        '52590',
        '40584',
        '62441',
        '64039',
        '68999',
        '64327',
        '33844',
        '52497',
        '88495',
        '25989',
        '67814',
        '13767',
        '83194',
        '99395',
        '35524',
        '89640',
        '48834',
        '51875',
        '71073',
        '25383',
        '19129',
        '57805',
        '47962',
        '61905',
        '19557',
        '74159',
        '98032',
        '13917',
        '50936',
        '47993',
        '41606',
        '17592',
        '11470',
        '28216',
        '19732',
        '97958',
        '60997',
        '85688',
        '96863',
        '16605',
        '10898',
        '31340',
        '71340',
        '72902',
        '98949',
        '74440',
        '53057',
        '30323',
        '76166',
        '27195',
        '11204',
        '32771',
        '38189',
        '83221',
        '22295',
        '15325',
        '20844',
        '65549',
        '69207',
        '71903',
        '63929',
        '56922',
        '25733',
        '75482',
        '14986',
        '79223',
        '73692',
        '98769',
        '70275',
        '33793',
        '13057',
        '30142',
        '95737',
        '30072',
        '32097',
        '25845',
        '50282',
        '19289',
        '92221',
        '59533',
        '37375',
        '29706',
        '48186',
        '22385',
        '55809',
        '17416',
        '10592',
        '55385',
        '71829',
        '91975',
        '73557',
        '38036',
        '10448',
        '95252',
        '51386',
        '14190',
        '15247',
        '39907',
        '79438',
        '78053',
        '66623',
        '27720',
        '84139',
        '74147',
        '58637',
        '11434',
        '36573',
        '10081',
        '53536',
        '41724',
        '97898',
        '36752',
        '50384',
        '87352',
        '35696',
        '69486',
        '50026',
        '27837',
        '42592',
        '58865',
        '80523',
        '53682',
        '65423',
        '77611',
        '98529',
        '13909',
        '13727',
        '52190',
        '36152',
        '48355',
        '62496',
        '16527',
        '18143',
        '98830',
        '75198',
        '73043',
        '64043',
        '63042',
        '67797',
        '50656',
        '27700',
        '60687',
        '57905',
        '94404',
        '15733',
        '80809',
        '74562',
        '84493',
        '67977',
        '11213',
        '19125',
        '84496',
        '16435',
        '97510',
        '46040',
        '33968',
        '20256',
        '42332',
        '16480',
        '54277',
        '82819',
        '93799',
        '69101',
        '57689',
        '42821',
        '68073',
        '49342',
        '46915',
        '25825',
        '92332',
        '20219',
        '96577',
        '49463',
        '19221',
        '35814',
        '64783',
        '97303',
        '52061',
        '24357',
        '58167',
        '56286',
        '64474',
        '99847',
        '53626',
        '39703',
        '24880',
        '24365',
        '50652',
        '29611',
        '90638',
        '59246',
        '27171',
        '30483',
        '11708',
        '38630',
        '81914',
        '48269',
        '11720',
        '88662',
        '68844',
        '54838',
        '93795',
        '38102',
        '33481',
        '97546',
        '49306',
        '97216',
        '49032',
        '14270',
        '72418',
        '32540',
        '53208',
        '15588',
        '29990',
        '10407',
        '92334',
        '48543',
        '51495',
        '77996',
        '53686',
        '14827',
        '30978',
        '30482',
        '86296',
        '48869',
        '59600',
        '29495',
        '24775',
        '34645',
        '19763',
        '98602',
        '20456',
        '10468',
        '13887',
        '65714',
        '74740',
        '37096',
        '96240',
        '44111',
        '54109',
        '62693',
        '87874',
        '64295',
        '62027',
        '86027',
        '54341',
        '68582',
        '67809',
        '44159',
        '97913',
        '79150',
        '38974',
        '64754',
        '73946',
        '20840',
        '16138',
        '58939',
        '20428',
        '19890',
        '70842',
        '78648',
        '55576',
        '37267',
        '40470',
        '12957',
        '57553',
        '53593',
        '34067',
        '22555',
        '79719',
        '25809',
        '28496',
        '11083',
        '87624',
        '83622',
        '84898',
        '28678',
        '14297',
        '79461',
        '22910',
        '87129',
        '49941',
        '64817',
        '93905',
        '39721',
        '81837',
        '18753',
        '86432',
        '67821',
        '66080',
        '28246',
        '13466',
        '16363',
        '56950',
        '35446',
        '58326',
        '11760',
        '33962',
        '28399',
        '45848',
        '52560',
        '66894',
        '15169',
        '20988',
        '85925',
        '38582',
        '34825',
        '94227',
        '56758',
        '24801',
        '14128',
        '14012',
        '35824',
        '49784'
      )
      
      INTERSECT
      
      SELECT ca_zip
      
      FROM (
        SELECT 
          substr(ca_zip, 1, 5) AS ca_zip,
          count(*) AS cnt
        
        FROM customer_address, customer
        
        WHERE ca_address_sk = c_current_addr_sk and
         c_preferred_cust_flag = 'Y'
        
        GROUP BY ca_zip
        
        HAVING count(*) > 10
       ) AS A1
     ) AS A2
   ) AS V1
  
  WHERE ss_store_sk = s_store_sk and ss_sold_date_sk = d_date_sk and d_qoy = 1 and d_year = 2002 and (substr(s_zip, 1, 2) = substr(V1.ca_zip, 1, 2))
  
  GROUP BY s_store_name
  
  ORDER BY s_store_name
  
  LIMIT 100

),

Join_2 AS (

  SELECT 
    in1.S_STORE_NAME AS S_STORE_NAME,
    in1."SUM(SS_NET_PROFIT)" AS SS_NET_PROFIT,
    in0.ITEMREVENUE AS ITEMREVENUE
  
  FROM SQLStatement_1 AS in0
  INNER JOIN SQLStatement_2 AS in1
     ON in0.I_ITEM_ID != in1.S_STORE_NAME

),

SQLStatement_4 AS (

  SELECT 
    count(DISTINCT ws_order_number) AS order_count,
    sum(ws_ext_ship_cost) AS total_shipping_cost,
    sum(ws_net_profit) AS total_net_profit
  
  FROM web_sales AS ws1, date_dim, customer_address, web_site
  
  WHERE d_date BETWEEN '2002-2-01' and
   dateadd(DAY, 60, to_date('2002-2-01')) and ws1.ws_ship_date_sk = d_date_sk and ws1.ws_ship_addr_sk = ca_address_sk and ca_state = 'CA' and ws1.ws_web_site_sk = web_site_sk and web_company_name = 'pri' and EXISTS
  (
    SELECT *
    
    FROM web_sales AS ws2
    
    WHERE ws1.ws_order_number = ws2.ws_order_number and ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
   )
   and not exists
  (
    SELECT *
    
    FROM web_returns AS wr1
    
    WHERE ws1.ws_order_number = wr1.wr_order_number
   )
  
  
  ORDER BY count(DISTINCT ws_order_number)
  
  LIMIT 100

),

SQLStatement_5 AS (

  SELECT sum(ws_ext_discount_amt) AS Excess_Discount_Amount
  
  FROM web_sales, item, date_dim
  
  WHERE i_manufact_id = 939 and i_item_sk = ws_item_sk and d_date BETWEEN '2002-02-16' and
   dateadd(DAY, 90, to_date('2002-02-16')) and d_date_sk = ws_sold_date_sk and ws_ext_discount_amt > (
    SELECT 1.3 * avg(ws_ext_discount_amt)
    
    FROM web_sales, date_dim
    
    WHERE ws_item_sk = i_item_sk and d_date BETWEEN '2002-02-16' and
     dateadd(DAY, 90, to_date('2002-02-16')) and d_date_sk = ws_sold_date_sk
   )
  
  ORDER BY sum(ws_ext_discount_amt)
  
  LIMIT 100

),

Join_3 AS (

  SELECT 
    in0.ORDER_COUNT AS ORDER_COUNT,
    in0.TOTAL_SHIPPING_COST AS TOTAL_SHIPPING_COST,
    in0.TOTAL_NET_PROFIT AS TOTAL_NET_PROFIT,
    in1.EXCESS_DISCOUNT_AMOUNT AS EXCESS_DISCOUNT_AMOUNT
  
  FROM SQLStatement_4 AS in0
  INNER JOIN SQLStatement_5 AS in1
     ON in0.ORDER_COUNT != in1.EXCESS_DISCOUNT_AMOUNT

),

SQLStatement_6 AS (

  SELECT 
    w_warehouse_name,
    w_warehouse_sq_ft,
    w_city,
    w_county,
    w_state,
    w_country,
    ship_carriers,
    year,
    sum(jan_sales) AS jan_sales,
    sum(feb_sales) AS feb_sales,
    sum(mar_sales) AS mar_sales,
    sum(apr_sales) AS apr_sales,
    sum(may_sales) AS may_sales,
    sum(jun_sales) AS jun_sales,
    sum(jul_sales) AS jul_sales,
    sum(aug_sales) AS aug_sales,
    sum(sep_sales) AS sep_sales,
    sum(oct_sales) AS oct_sales,
    sum(nov_sales) AS nov_sales,
    sum(dec_sales) AS dec_sales,
    sum(jan_sales / w_warehouse_sq_ft) AS jan_sales_per_sq_foot,
    sum(feb_sales / w_warehouse_sq_ft) AS feb_sales_per_sq_foot,
    sum(mar_sales / w_warehouse_sq_ft) AS mar_sales_per_sq_foot,
    sum(apr_sales / w_warehouse_sq_ft) AS apr_sales_per_sq_foot,
    sum(may_sales / w_warehouse_sq_ft) AS may_sales_per_sq_foot,
    sum(jun_sales / w_warehouse_sq_ft) AS jun_sales_per_sq_foot,
    sum(jul_sales / w_warehouse_sq_ft) AS jul_sales_per_sq_foot,
    sum(aug_sales / w_warehouse_sq_ft) AS aug_sales_per_sq_foot,
    sum(sep_sales / w_warehouse_sq_ft) AS sep_sales_per_sq_foot,
    sum(oct_sales / w_warehouse_sq_ft) AS oct_sales_per_sq_foot,
    sum(nov_sales / w_warehouse_sq_ft) AS nov_sales_per_sq_foot,
    sum(dec_sales / w_warehouse_sq_ft) AS dec_sales_per_sq_foot,
    sum(jan_net) AS jan_net,
    sum(feb_net) AS feb_net,
    sum(mar_net) AS mar_net,
    sum(apr_net) AS apr_net,
    sum(may_net) AS may_net,
    sum(jun_net) AS jun_net,
    sum(jul_net) AS jul_net,
    sum(aug_net) AS aug_net,
    sum(sep_net) AS sep_net,
    sum(oct_net) AS oct_net,
    sum(nov_net) AS nov_net,
    sum(dec_net) AS dec_net
  
  FROM (
    SELECT 
      w_warehouse_name,
      w_warehouse_sq_ft,
      w_city,
      w_county,
      w_state,
      w_country,
      'GREAT EASTERN' || ',' || 'UPS' AS ship_carriers,
      d_year AS year,
      sum(CASE
        WHEN d_moy = 1
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS jan_sales,
      sum(CASE
        WHEN d_moy = 2
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS feb_sales,
      sum(CASE
        WHEN d_moy = 3
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS mar_sales,
      sum(CASE
        WHEN d_moy = 4
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS apr_sales,
      sum(CASE
        WHEN d_moy = 5
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS may_sales,
      sum(CASE
        WHEN d_moy = 6
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS jun_sales,
      sum(CASE
        WHEN d_moy = 7
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS jul_sales,
      sum(CASE
        WHEN d_moy = 8
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS aug_sales,
      sum(CASE
        WHEN d_moy = 9
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS sep_sales,
      sum(CASE
        WHEN d_moy = 10
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS oct_sales,
      sum(CASE
        WHEN d_moy = 11
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS nov_sales,
      sum(CASE
        WHEN d_moy = 12
          THEN ws_ext_sales_price * ws_quantity
        ELSE 0
      END) AS dec_sales,
      sum(CASE
        WHEN d_moy = 1
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS jan_net,
      sum(CASE
        WHEN d_moy = 2
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS feb_net,
      sum(CASE
        WHEN d_moy = 3
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS mar_net,
      sum(CASE
        WHEN d_moy = 4
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS apr_net,
      sum(CASE
        WHEN d_moy = 5
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS may_net,
      sum(CASE
        WHEN d_moy = 6
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS jun_net,
      sum(CASE
        WHEN d_moy = 7
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS jul_net,
      sum(CASE
        WHEN d_moy = 8
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS aug_net,
      sum(CASE
        WHEN d_moy = 9
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS sep_net,
      sum(CASE
        WHEN d_moy = 10
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS oct_net,
      sum(CASE
        WHEN d_moy = 11
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS nov_net,
      sum(CASE
        WHEN d_moy = 12
          THEN ws_net_paid * ws_quantity
        ELSE 0
      END) AS dec_net
    
    FROM web_sales, warehouse, date_dim, time_dim, ship_mode
    
    WHERE ws_warehouse_sk = w_warehouse_sk and ws_sold_date_sk = d_date_sk and ws_sold_time_sk = t_time_sk and ws_ship_mode_sk = sm_ship_mode_sk and d_year = 1998 and t_time BETWEEN 46866 and 46866 + 28800 and sm_carrier IN ('GREAT EASTERN', 'UPS')
    
    GROUP BY 
      w_warehouse_name, w_warehouse_sq_ft, w_city, w_county, w_state, w_country, d_year
    
    UNION ALL
    
    SELECT 
      w_warehouse_name,
      w_warehouse_sq_ft,
      w_city,
      w_county,
      w_state,
      w_country,
      'GREAT EASTERN' || ',' || 'UPS' AS ship_carriers,
      d_year AS year,
      sum(CASE
        WHEN d_moy = 1
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS jan_sales,
      sum(CASE
        WHEN d_moy = 2
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS feb_sales,
      sum(CASE
        WHEN d_moy = 3
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS mar_sales,
      sum(CASE
        WHEN d_moy = 4
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS apr_sales,
      sum(CASE
        WHEN d_moy = 5
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS may_sales,
      sum(CASE
        WHEN d_moy = 6
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS jun_sales,
      sum(CASE
        WHEN d_moy = 7
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS jul_sales,
      sum(CASE
        WHEN d_moy = 8
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS aug_sales,
      sum(CASE
        WHEN d_moy = 9
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS sep_sales,
      sum(CASE
        WHEN d_moy = 10
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS oct_sales,
      sum(CASE
        WHEN d_moy = 11
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS nov_sales,
      sum(CASE
        WHEN d_moy = 12
          THEN cs_sales_price * cs_quantity
        ELSE 0
      END) AS dec_sales,
      sum(CASE
        WHEN d_moy = 1
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS jan_net,
      sum(CASE
        WHEN d_moy = 2
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS feb_net,
      sum(CASE
        WHEN d_moy = 3
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS mar_net,
      sum(CASE
        WHEN d_moy = 4
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS apr_net,
      sum(CASE
        WHEN d_moy = 5
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS may_net,
      sum(CASE
        WHEN d_moy = 6
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS jun_net,
      sum(CASE
        WHEN d_moy = 7
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS jul_net,
      sum(CASE
        WHEN d_moy = 8
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS aug_net,
      sum(CASE
        WHEN d_moy = 9
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS sep_net,
      sum(CASE
        WHEN d_moy = 10
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS oct_net,
      sum(CASE
        WHEN d_moy = 11
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS nov_net,
      sum(CASE
        WHEN d_moy = 12
          THEN cs_net_paid * cs_quantity
        ELSE 0
      END) AS dec_net
    
    FROM catalog_sales, warehouse, date_dim, time_dim, ship_mode
    
    WHERE cs_warehouse_sk = w_warehouse_sk and cs_sold_date_sk = d_date_sk and cs_sold_time_sk = t_time_sk and cs_ship_mode_sk = sm_ship_mode_sk and d_year = 1998 and t_time BETWEEN 46866 and 46866 + 28800 and sm_carrier IN ('GREAT EASTERN', 'UPS')
    
    GROUP BY 
      w_warehouse_name, w_warehouse_sq_ft, w_city, w_county, w_state, w_country, d_year
   ) AS x
  
  GROUP BY 
    w_warehouse_name, w_warehouse_sq_ft, w_city, w_county, w_state, w_country, ship_carriers, year
  
  ORDER BY w_warehouse_name
  
  LIMIT 100

),

SQLStatement_7 AS (

  SELECT sum(ss_quantity)
  
  FROM store_sales, store, customer_demographics, customer_address, date_dim
  
  WHERE s_store_sk = ss_store_sk and ss_sold_date_sk = d_date_sk and d_year = 2001 and
   ((cd_demo_sk = ss_cdemo_sk and
   cd_marital_status = 'D' and
   cd_education_status = 'Secondary' and
   ss_sales_price BETWEEN 100.0 and 150.0) or
   (cd_demo_sk = ss_cdemo_sk and
   cd_marital_status = 'W' and
   cd_education_status = '2 yr Degree' and
   ss_sales_price BETWEEN 50.0 and 100.0) or
   (cd_demo_sk = ss_cdemo_sk and
   cd_marital_status = 'U' and
   cd_education_status = 'Unknown' and
   ss_sales_price BETWEEN 150.0 and 200.0)) and
   ((ss_addr_sk = ca_address_sk and
   ca_country = 'United States' and
   ca_state IN ('VA', 'MI', 'FL') and ss_net_profit BETWEEN 0 and 2000) or
   (ss_addr_sk = ca_address_sk and
   ca_country = 'United States' and
   ca_state IN ('SC', 'GA', 'MN') and ss_net_profit BETWEEN 150 and 3000) or
   (ss_addr_sk = ca_address_sk and
   ca_country = 'United States' and
   ca_state IN ('OK', 'IA', 'TX') and ss_net_profit BETWEEN 50 and 25000))

),

Join_4 AS (

  SELECT 
    in1.W_WAREHOUSE_NAME AS W_WAREHOUSE_NAME,
    in1.W_WAREHOUSE_SQ_FT AS W_WAREHOUSE_SQ_FT,
    in1.JAN_SALES AS JAN_SALES
  
  FROM SQLStatement_7 AS in0
  INNER JOIN SQLStatement_6 AS in1
     ON in0."SUM(SS_QUANTITY)" != in1.W_WAREHOUSE_SQ_FT

),

Join_5 AS (

  SELECT 
    in0.ORDER_COUNT AS ORDER_COUNT,
    in0.TOTAL_SHIPPING_COST AS TOTAL_SHIPPING_COST,
    in0.TOTAL_NET_PROFIT AS TOTAL_NET_PROFIT,
    in0.EXCESS_DISCOUNT_AMOUNT AS EXCESS_DISCOUNT_AMOUNT,
    in1.W_WAREHOUSE_NAME AS W_WAREHOUSE_NAME,
    in1.W_WAREHOUSE_SQ_FT AS W_WAREHOUSE_SQ_FT,
    in1.JAN_SALES AS JAN_SALES
  
  FROM Join_3 AS in0
  INNER JOIN Join_4 AS in1
     ON in0.ORDER_COUNT != in1.JAN_SALES

),

Join_6 AS (

  SELECT 
    in0.I_ITEM_ID AS I_ITEM_ID,
    in0.I_ITEM_DESC AS I_ITEM_DESC,
    in0.I_CATEGORY AS I_CATEGORY,
    in0.I_CLASS AS I_CLASS,
    in0.I_CURRENT_PRICE AS I_CURRENT_PRICE,
    in0.ITEMREVENUE AS ITEMREVENUE,
    in0.REVENUERATIO AS REVENUERATIO,
    in0.SM_TYPE AS SM_TYPE,
    in0.CC_NAME AS CC_NAME
  
  FROM Join_1 AS in0
  INNER JOIN Join_2 AS in1
     ON in0.I_CATEGORY != in1.S_STORE_NAME

),

Join_7 AS (

  SELECT 
    in0.I_ITEM_ID AS I_ITEM_ID,
    in0.I_ITEM_DESC AS I_ITEM_DESC,
    in0.I_CATEGORY AS I_CATEGORY,
    in0.I_CLASS AS I_CLASS,
    in0.I_CURRENT_PRICE AS I_CURRENT_PRICE,
    in0.ITEMREVENUE AS ITEMREVENUE,
    in0.REVENUERATIO AS REVENUERATIO,
    in0.SM_TYPE AS SM_TYPE,
    in0.CC_NAME AS CC_NAME
  
  FROM Join_6 AS in0
  INNER JOIN Join_5 AS in1
     ON in0.I_CURRENT_PRICE != in1.ORDER_COUNT

)

SELECT *

FROM Join_7
