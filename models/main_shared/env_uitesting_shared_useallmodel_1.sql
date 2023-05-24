{% set v_int = 22 %}
{% set v_bool = True %}
{% set v_expression = "concat(C_VARCHAR, C_TEXT, C_ARRAY[0], C_OBJECT['outer_key2']['inner_key2'])" %}



WITH goods_classification AS (

  SELECT * 
  
  FROM {{ ref('goods_classification')}}

),

default__test_accepted_range_1 AS (

  {{ dbt_utils.default__test_accepted_range(model = 'goods_classification', column_name = 'NZHSC_Level_1_Code_HS2', min_value = 10, max_value = 15) }}

),

service_classification AS (

  SELECT * 
  
  FROM {{ ref('service_classification')}}

),

snowflake__language_specific_deduplicate_base_1 AS (

  {{ SQL_BaseGitDepProjectAllFinal.snowflake__language_specific_deduplicate_base(relation = 'service_classification', partition_by = 'code_1', order_by = 'service_label_1') }}

),

Join_3 AS (

  SELECT 
    in0.NZHSC_LEVEL_2_CODE_HS4 AS NZHSC_LEVEL_2_CODE_HS4,
    in0.NZHSC_LEVEL_1_CODE_HS2 AS NZHSC_LEVEL_1_CODE_HS2,
    in0.NZHSC_LEVEL_2 AS NZHSC_LEVEL_2,
    in0.NZHSC_LEVEL_1 AS NZHSC_LEVEL_1,
    in0.STATUS_HS4 AS STATUS_HS4,
    in1.CODE_1 AS CODE_1,
    in1.SERVICE_LABEL_1 AS SERVICE_LABEL_1
  
  FROM default__test_accepted_range_1 AS in0
  INNER JOIN snowflake__language_specific_deduplicate_base_1 AS in1
     ON in0.STATUS_HS4 != in1.CODE_1

),

tpcds_1_env_uitesting_shared AS (

  SELECT * 
  
  FROM {{ ref('tpcds_1_env_uitesting_shared')}}

),

env_uitesting_main_model_snow_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_main_model_snow_1')}}

),

TABLE_COMPLEX_TYPES_1_1 AS (

  SELECT * 
  
  FROM {{ source('QA_DATABASE.QA_SIMPLE_SCHEMA', 'TABLE_COMPLEX_TYPES_1') }}

),

env_uitesting_shared_parent_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_parent_model_1')}}

),

AllStunningOne AS (

  SELECT 
    CONDITIONAL_CHANGE_EVENT(
      c_int = 10) OVER (ORDER BY c_string) + NTH_VALUE(c_int, 2) OVER (PARTITION BY c_float ORDER BY c_string) + RANK() OVER (ORDER BY c_int DESC) + DENSE_RANK() OVER (ORDER BY c_int DESC) + ST_PERIMETER(TO_GEOGRAPHY('POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))')) + ST_HAUSDORFFDISTANCE(ST_POINT(0, 0), ST_POINT(0, 1)) + EXTRACT(YEAR FROM TO_TIMESTAMP('2013-05-08T23:39:20.123-07:00')) + DATE_PART(QUARTER, '2013-05-08'::DATE) + abs(-10) + ceil(10.12) + floor(12.5656) + mod(10, 2) + round(-975.975, 1) + SIGN(-1.35E-10) + truncate(4.23423) + truncate(4.23423, 2) + cbrt(8) + exp(2) + factorial(1) + pow(2, 3) + power(1, 2) + sqrt(4) + square(2) + ln(10) + log(10, 10) + COS(0) + COS(PI() / 3) + COS(RADIANS(90)) + SIN(0) + SIN(PI() / 3) + SIN(RADIANS(90)) - HAVERSINE(40.7127, -74.0059, 34.05, -118.25) + DAYOFMONTH('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) AS c_add_expression,
    concat(
      TRIM('?-?ABC-?-', '?-'), 
      REPLACE('abcd', 'bc'), 
      RIGHT('ABCDEFG', 3), 
      CAST(HASH(SEQ8()) AS string), 
      ASCII('A'), 
      REPEAT('xy', 5), 
      REVERSE('Hello, world!'), 
      SUBSTR('testing 1 2 3', 9, 5), 
      INSERT('abc', 1, 2, 'Z'), 
      RTRIM('$125.00', '0.'), 
      UUID_STRING(), 
      sha1('Snowflake'), 
      CAST(md5_binary('Snowflake') AS string), 
      LPAD(' hello ', 10, ' '), 
      DECOMPRESS_STRING(TO_BINARY('0920536E6F77666C616B65', 'HEX'), 'SNAPPY'), 
      LPAD('.  hi. ', 10, '$'), 
      DAYNAME(TO_DATE('2015-05-01')), 
      CAST(LAST_DAY(TO_DATE('2015-05-08T23:39:20.123-07:00')) AS string), 
      CAST(DATEADD(YEAR, 2, TO_DATE('2013-05-08')) AS string), 
      CAST(DATEDIFF(MONTH, '2021-01-01'::DATE, '2021-02-28'::DATE) AS string), 
      CAST(DATEDIFF(
        HOUR, 
        '2013-05-08T23:39:20.123-07:00'::TIMESTAMP, 
        DATEADD(YEAR, 2, ('2013-05-08T23:39:20.123-07:00')::TIMESTAMP)) AS string), 
      CAST(TIMEDIFF(YEAR, '2017-01-01', '2019-01-01') AS string), 
      CAST(TIME_SLICE('2019-02-28'::DATE, 4, 'MONTH', 'START') AS string), 
      CAST(TRY_TO_TIME('12:30:00') AS string)) AS c_concat_expression,
    2 = 5 or 5 != 10 or 6 <> 7 or 4 > 2 or 5 <= 10 or startswith('sasd', 'te') or REGEXP_LIKE('sanson', 'san.*') or RLIKE('city', 'san.*', 'i') or CONTAINS('hello', 'te') or ('subject' LIKE '%j%h%do%') or (BITNOT(10) = 2) or BITAND(1, 2) = 2 or BITOR(3, 4) = 5 or BITXOR(7, 8) = 4 or GETBIT(11, 100) = 0 or (1.35 BETWEEN 1 and 2) or BOOLAND(1, -2) or BOOLNOT(10) or BOOLOR(-1.35, 0) or BOOLXOR(1, -1) or (COALESCE(1, 2, 3) = 2) or (decode(1, 1, 'one', 2, 'two', NULL, '-NULL-', 'other') = 'one') or EQUAL_NULL(1, 1) or (GREATEST(1, 2, 3) = 3) or iff(True, 'true', 'false') or ifnull(0, 1) = 0 or (NULL IN (1, 2, NULL)) or (NULL NOT IN (1, 2, NULL)) or (1 IS NOT DISTINCT FROM 1) or (1 IS NOT NULL) or LEAST(1, 3, 0, 4) = 0 or NULLIF(1, 2) = 0 or NULLIFZERO(0) = NULL or NVL('food', 'bard') = 'food' or NVL2(2, 3, 5) = 5 or REGR_VALX(NULL, 10) = NULL or REGR_VALY(NULL, 10) = NULL or ZEROIFNULL(1.0) = 10 or (CURRENT_CLIENT() LIKE '%Snow%') or (CAST(CURRENT_TIME(2) AS string) LIKE '%2020%') or (LOCALTIMESTAMP() = CURRENT_TIMESTAMP) or (CURRENT_WAREHOUSE() != CURRENT_SCHEMA()) or (CURRENT_USER() = 'Abhishek') or TRY_CAST('ABCD' AS VARCHAR (10)) = 'ABCD' or TRY_TO_TIMESTAMP('Invalid') = NULL or TO_ARRAY(1) = TO_ARRAY(1) or PARSE_JSON('{"a":1}') = PARSE_JSON('{"a":1}') or TO_OBJECT(PARSE_JSON('{"a":1}')) = TO_OBJECT(PARSE_JSON('{"a":1}')) or TO_VARIANT(3.14) = TO_VARIANT(3.14) or (TRY_TO_GEOGRAPHY('Not a valid input for this data type.') IS NULL) or (random() > 10) or normal(0, 1, random()) > 10 or uniform(1, 10, random()) = 10 or zipf(1, 10, random()) = 9 or DATE_FROM_PARTS(2010, 1, 100) = DATE_FROM_PARTS(2010, 1, 100) or time_from_parts(0, 100, 0) IS NOT NULL or timestamp_ntz_from_parts(2013, 4, 5, 12, 0, 0, 987654321) IS NOT NULL or DATE_PART(QUARTER, '2013-05-08'::DATE) = 2 or DAYNAME('2013-05-08') IS NOT NULL or EXTRACT(YEAR FROM TO_TIMESTAMP('2013-05-08T23:39:20.123-07:00')) = 2013 or MONTHNAME(TO_TIMESTAMP('2015-04-03 10:00')) IS NOT NULL or PREVIOUS_DAY('2020-10-10', 'Friday ') IS NOT NULL or DAYOFMONTH('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or DAYOFWEEK('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or DAYOFWEEKISO('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or DAYOFYEAR('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or DAY('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or WEEK('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or WEEKISO('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or WEEKOFYEAR('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or MONTH('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or QUARTER('2013-05-08T23:39:20.123-07:00'::TIMESTAMP) IS NOT NULL or ADD_MONTHS('2016-05-15'::timestamp_ntz, 2) IS NOT NULL or DATEADD(MONTH, 1, '2000-01-31'::DATE) IS NOT NULL or DATEDIFF(YEAR, '2010-04-09 14:39:20'::TIMESTAMP, '2013-05-08 23:39:20'::TIMESTAMP) IS NOT NULL or ROUND(MONTHS_BETWEEN('2019-03-31 12:00:00'::TIMESTAMP, '2019-02-28 00:00:00'::TIMESTAMP)) IS NOT NULL or DATEADD(HOUR, 2, TO_TIMESTAMP_LTZ('2013-05-08 11:22:33.444')) IS NOT NULL or DATE_TRUNC('HOUR', TO_TIMESTAMP('2015-05-08T23:39:20.123-07:00')) IS NOT NULL or TIME_SLICE('2019-02-28'::DATE, 4, 'MONTH', 'START') IS NOT NULL or trunc(to_date('2013-05-08'), 'QUARTER') IS NOT NULL or ST_PERIMETER(TO_GEOGRAPHY('POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))')) IS NOT NULL or ST_DWITHIN(ST_MAKEPOINT(0, 0), ST_MAKEPOINT(1, 0), 150000) or ST_DISJOINT(
      TO_GEOGRAPHY('POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))'), 
      TO_GEOGRAPHY('POLYGON((3 3, 5 3, 5 5, 3 5, 3 3))')) or ST_STARTPOINT(TO_GEOMETRY('LINESTRING(1 1, 2 2, 3 3, 4 4)')) IS NOT NULL or ST_ENDPOINT(TO_GEOGRAPHY('LINESTRING(1 1, 2 2, 3 3, 4 4)')) IS NOT NULL or ST_SIMPLIFY(TO_GEOGRAPHY('LINESTRING(-122.306067 37.55412, -122.32328 37.561801, -122.325879 37.586852)'), 1000) IS NOT NULL or ST_INTERSECTION(TO_GEOGRAPHY('POLYGON((0 0, 1 0, 2 1, 1 2, 2 3, 1 4, 0 4, 0 0))'), TO_GEOGRAPHY('POINT(0 2)')) IS NOT NULL or ST_GEOGFROMGEOHASH('9q9j8ue2v71y5zzy0s4q') IS NOT NULL or ST_AREA(ST_MAKEPOLYGONORIENTED(TO_GEOGRAPHY('LINESTRING(0.0 0.0, 1.0 0.0, 1.0 2.0, 0.0 2.0, 0.0 0.0)'))) > 20 or ST_GEOGRAPHYFROMWKT('POINT(-122.35 37.55)') IS NOT NULL or ST_XMAX(TO_GEOGRAPHY('POINT(-180 0)')) IS NOT NULL or ST_XMIN(TO_GEOGRAPHY('POINT(-180 0)')) IS NOT NULL or ST_POINTN(TO_GEOGRAPHY('LINESTRING(1 1, 2 2, 3 3, 4 4)'), 2) IS NOT NULL or ST_BUFFER(TO_GEOMETRY('POINT(0 0)'), 1) IS NOT NULL or ST_CENTROID(TO_GEOGRAPHY('LINESTRING(0 0, 0 -2)')) IS NOT NULL or ST_INTERSECTION(
      TO_GEOGRAPHY('POLYGON((0 0, 1 0, 2 1, 1 2, 2 3, 1 4, 0 4, 0 0))'), 
      TO_GEOGRAPHY('POLYGON((3 0, 3 4, 2 4, 1 3, 2 2, 1 1, 2 0, 3 0))')) IS NOT NULL or ST_SYMDIFFERENCE(
      TO_GEOGRAPHY('POLYGON((0 0, 1 0, 2 1, 1 2, 2 3, 1 4, 0 4, 0 0))'), 
      TO_GEOGRAPHY('POLYGON((3 0, 3 4, 2 4, 1 3, 2 2, 1 1, 2 0, 3 0))')) IS NOT NULL or ST_UNION(TO_GEOGRAPHY('POINT(1 1)'), TO_GEOGRAPHY('LINESTRING(1 0, 1 2)')) IS NOT NULL or CHECK_XML('<name> Valid </name>') IS NOT NULL or CHECK_JSON('{"a": 2}') IS NOT NULL or JSON_EXTRACT_PATH_TEXT('{"level_1_key": {"level_2_key": "level_2_value"}}', 'level_1_key') IS NOT NULL or PARSE_JSON('null') IS NOT NULL or ARRAY_APPEND(ARRAY_CONSTRUCT(1, 2, 3), 'HELLO') IS NOT NULL or ARRAY_CAT(ARRAY_CONSTRUCT(1, 2), ARRAY_CONSTRUCT(1, 2)) IS NOT NULL or ARRAY_COMPACT(ARRAY_CONSTRUCT(1, 2)) IS NOT NULL or ARRAY_CONTAINS('hello'::variant, array_construct('hello', 'hi')) or ARRAY_DISTINCT(['A', 'A', 'B', NULL, NULL]) IS NOT NULL or ARRAY_INSERT(ARRAY_CONSTRUCT(0, 1, 2, 3), 2, 'hello') IS NOT NULL or array_intersection(ARRAY_CONSTRUCT('A', 'B'), ARRAY_CONSTRUCT('B', 'C')) IS NOT NULL or ARRAY_PREPEND(ARRAY_CONSTRUCT(0, 1, 2, 3), 'hello') IS NOT NULL or ARRAY_SIZE(ARRAY_CONSTRUCT(1, 2, 3)) > 2 or array_slice(array_construct(0, 1, 2, 3, 4, 5, 6), 0, 2) IS NOT NULL or ARRAY_TO_STRING(PARSE_JSON(NULL), '') IS NULL or ARRAYS_OVERLAP(array_construct('hello', 'aloha'), array_construct('hello', 'hi', 'hey')) or OBJECT_CONSTRUCT('a', 1, 'b', 'BBBB', 'c', NULL) IS NOT NULL or OBJECT_DELETE(OBJECT_CONSTRUCT('a', 1, 'b', 2, 'c', 3), 'a', 'b') IS NOT NULL or OBJECT_INSERT(OBJECT_CONSTRUCT('a', 1, 'b', 2), 'c', 3) IS NOT NULL or OBJECT_PICK(OBJECT_CONSTRUCT('a', 1, 'b', 2, 'c', 3), 'a', 'b') IS NOT NULL or TO_ARRAY(1) IS NOT NULL or AS_DECIMAL(TO_VARIANT(TO_DECIMAL(1.23, 6, 3)), 6, 3) IS NOT NULL or typeof(10) IS NOT NULL or split_part('11.22.33', '.', 0) IS NOT NULL AS c_bool_expression,
    C_NUM AS C_NUM,
    C_NUM10 AS C_NUM10,
    C_DEC AS C_DEC,
    C_NUMERIC AS C_NUMERIC,
    C_INT AS C_INT,
    C_INTEGER AS C_INTEGER,
    C_DOUBLE AS C_DOUBLE,
    C_FLOAT AS C_FLOAT,
    C_COUBLE_PRECISION AS C_COUBLE_PRECISION,
    C_REAL AS C_REAL,
    concat(C_VARCHAR, C_TEXT, C_ARRAY[0], C_OBJECT['outer_key2']['inner_key2'], C_VARCHAR) AS C_VARCHAR,
    C_VARCHAR50 AS C_VARCHAR50,
    C_CHAR AS C_CHAR,
    C_CHAR10 AS C_CHAR10,
    C_STRING AS C_STRING,
    C_STRING20 AS C_STRING20,
    C_TEXT AS C_TEXT,
    C_TEXT30 AS C_TEXT30,
    C_BINARY AS C_BINARY,
    C_BINARY100 AS C_BINARY100,
    C_VARBINARY AS C_VARBINARY,
    C_BOOL AS C_BOOL,
    C_TIMESTAMP AS C_TIMESTAMP,
    C_DATE AS C_DATE,
    C_DATETIME AS C_DATETIME,
    C_TIME AS C_TIME,
    C_ARRAY AS C_ARRAY,
    C_OBJECT AS C_OBJECT,
    C_GEOGRAPHY AS C_GEOGRAPHY,
    {% for c_ifor in range(1, 5) %}
      concat(C_STRING, {{c_ifor}}) AS col_for_{{c_ifor}},
    {% endfor %}
    
    {% if v_int > 10 and         var('v_p_dict')['a'] == 10 %}
      concat(C_STRING, C_BOOL) AS c_if,
    {% elif v_bool == True or         var('v_p_complex_dict')['a'][0] > 10 %}
      concat(C_STRING, C_INT) AS c_if,
    {% else %}
      concat(C_STRING, C_INTEGER) AS c_if,
    {% endif %}
    concat(C_STRING20, {{ SQL_SnowflakeSharedBasic.qa_concat_function_main('c_string', 'c_integer') }}) AS c_macro_1,
    concat(
      '{{ dbt_utils.pretty_time() }}', 
      '{{ dbt_utils.pretty_log_format("my pretty message") }}', 
      {{ SQL_BaseGitDepProjectAllFinal.qa_concat_macro_base_column('c_string') }}, 
      {{ SQL_SnoflakeMainProject.qa_concat_macro_column('c_string') }}) AS c_macro_from_dependent_projects,
    {{ SQL_SnoflakeMainProject.snowflake__language_specific_concat() }} AS c_macro_language_specific_concat,
    {{ dbt_date.snowflake__day_name('c_date', 2) }} AS c_dbt_date_call,
    {{v_expression}} AS c_config_value_in_expression,
    js_factorial(c_int) % MULTIPLY1(c_float, 2) AS c_call_function
  
  FROM env_uitesting_shared_parent_model_1 AS in0

),

Aggregate_1 AS (

  SELECT 
    ANY_VALUE(c_int) AS c_any_value,
    AVG(c_int) AS c_avg,
    CORR(c_int, c_num) AS c_corr,
    APPROX_PERCENTILE(c_int, 0.1) + regr_slope(c_int, c_num) + REGR_AVGX(c_int, c_num) + bitand_agg(c_int) + bitand_agg(c_int) + min(c_int) + median(c_int) + max(c_int) + COUNT(DISTINCT c_int) + STDDEV(c_int) + var_samp(c_int) AS c_min,
    COVAR_POP(c_int, c_num) AS c_covarpop,
    boolor_agg(c_bool) or boolor_agg(c_bool) AS c_bool,
    approx_top_k_accumulate(c_int, 2) AS c_top_2_accumulate,
    ANY_VALUE(c_string) AS c_string
  
  FROM AllStunningOne AS in0
  
  GROUP BY c_bool
  
  HAVING c_avg > 0

),

env_uitesting_shared_child_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_child_model_1')}}

),

env_uitesting_shared_mid_model_1 AS (

  SELECT * 
  
  FROM {{ ref('env_uitesting_shared_mid_model_1')}}

),

model_with_only_seed_base AS (

  SELECT * 
  
  FROM {{ ref('model_with_only_seed_base')}}

),

Join_1 AS (

  SELECT 
    in0.C_NUM AS C_NUM,
    in0.C_NUM10 AS C_NUM10,
    in1.C_DEC AS C_DEC,
    in0.C_NUMERIC AS C_NUMERIC,
    in3.C_INT AS C_INT,
    in0.C_INTEGER AS C_INTEGER,
    in0.C_DOUBLE AS C_DOUBLE,
    in0.C_FLOAT AS C_FLOAT,
    in0.C_COUBLE_PRECISION AS C_COUBLE_PRECISION,
    in0.C_REAL AS C_REAL,
    in0.C_VARCHAR AS C_VARCHAR,
    in0.C_VARCHAR50 AS C_VARCHAR50,
    in0.C_CHAR AS C_CHAR,
    in0.C_CHAR10 AS C_CHAR10,
    in0.C_STRING AS C_STRING,
    in0.C_STRING20 AS C_STRING20,
    in0.C_TEXT AS C_TEXT,
    in0.C_TEXT30 AS C_TEXT30,
    in0.C_BINARY AS C_BINARY,
    in0.C_BINARY100 AS C_BINARY100,
    in0.C_VARBINARY AS C_VARBINARY,
    in0.C_BOOL AS C_BOOL,
    in0.C_TIMESTAMP AS C_TIMESTAMP,
    in0.C_DATE AS C_DATE,
    in0.C_DATETIME AS C_DATETIME,
    in0.C_TIME AS C_TIME,
    in0.C_ARRAY AS C_ARRAY,
    in0.C_OBJECT AS C_OBJECT,
    in0.C_GEOGRAPHY AS C_GEOGRAPHY
  
  FROM env_uitesting_shared_child_model_1 AS in0
  INNER JOIN env_uitesting_shared_mid_model_1 AS in1
     ON in0.c_num = in1.c_num
  LEFT JOIN model_with_only_seed_base AS in2
     ON in1.C_STRING != in2.CODE_1
  RIGHT JOIN env_uitesting_main_model_snow_1 AS in3
     ON in1.C_INT != in3.C_NUM

),

Reformat_2 AS (

  SELECT 
    C_ARRAY_INT AS C_ARRAY_INT,
    C_ARRAY_FLOAT AS C_ARRAY_FLOAT,
    C_ARRAY_STRING AS C_ARRAY_STRING,
    C_ARRAY_OBJECT AS C_ARRAY_OBJECT,
    C_ARRAY_ARRAY AS C_ARRAY_ARRAY,
    C_ARRAY_VARIANT AS C_ARRAY_VARIANT,
    C_OBJECT_1 AS C_OBJECT_1,
    C_OBJECT_2 AS C_OBJECT_2,
    C_OBJECT_3 AS C_OBJECT_3,
    C_OBJECT_4 AS C_OBJECT_4,
    C_OBJECT_5 AS C_OBJECT_5,
    C_VARIANT_1 AS C_VARIANT_1,
    C_VARIANT_2 AS C_VARIANT_2,
    C_VARIANT_3 AS C_VARIANT_3,
    C_VARIANT_4 AS C_VARIANT_4,
    C_VARIANT_5 AS C_VARIANT_5,
    concat('a', 'b') AS C_STR_UTILS,
    C_VARIANT_1['problems_6']['another_problem']['root']['cause'] AS cause,
    C_VARIANT_4['address']['city'] AS city
  
  FROM TABLE_COMPLEX_TYPES_1_1 AS in0

),

TABLE_COMPLEX_TYPES_1 AS (

  SELECT * 
  
  FROM {{ source('QA_DATABASE.QA_SIMPLE_SCHEMA', 'TABLE_COMPLEX_TYPES_1') }}

),

Reformat_1 AS (

  SELECT 
    C_ARRAY_INT AS C_ARRAY_INT,
    C_ARRAY_FLOAT AS C_ARRAY_FLOAT,
    C_ARRAY_STRING AS C_ARRAY_STRING,
    C_ARRAY_OBJECT AS C_ARRAY_OBJECT,
    C_ARRAY_ARRAY AS C_ARRAY_ARRAY,
    C_ARRAY_VARIANT AS C_ARRAY_VARIANT,
    C_OBJECT_1 AS C_OBJECT_1,
    C_OBJECT_2 AS C_OBJECT_2,
    C_OBJECT_3 AS C_OBJECT_3,
    C_OBJECT_4 AS C_OBJECT_4,
    C_OBJECT_5 AS C_OBJECT_5,
    C_VARIANT_1 AS C_VARIANT_1,
    C_VARIANT_2 AS C_VARIANT_2,
    C_VARIANT_3 AS C_VARIANT_3,
    C_VARIANT_4 AS C_VARIANT_4,
    C_VARIANT_5 AS C_VARIANT_5,
    concat('{{ dbt_utils.pretty_time() }}', '{{ dbt_utils.pretty_log_format("my pretty message") }}') AS C_STR_UTILS
  
  FROM TABLE_COMPLEX_TYPES_1 AS in0

),

Join_4 AS (

  SELECT 
    in0.C_ARRAY_INT AS C_ARRAY_INT,
    in0.C_ARRAY_FLOAT AS C_ARRAY_FLOAT,
    in0.C_ARRAY_STRING AS C_ARRAY_STRING,
    in0.C_ARRAY_OBJECT AS C_ARRAY_OBJECT,
    in0.C_ARRAY_ARRAY AS C_ARRAY_ARRAY,
    in0.C_ARRAY_VARIANT AS C_ARRAY_VARIANT,
    in0.C_OBJECT_1 AS C_OBJECT_1,
    in0.C_OBJECT_2 AS C_OBJECT_2,
    in0.C_OBJECT_3 AS C_OBJECT_3,
    in0.C_OBJECT_4 AS C_OBJECT_4,
    in0.C_OBJECT_5 AS C_OBJECT_5,
    in0.C_VARIANT_1 AS C_VARIANT_1,
    in0.C_VARIANT_2 AS C_VARIANT_2,
    in0.C_VARIANT_3 AS C_VARIANT_3,
    in0.C_VARIANT_4 AS C_VARIANT_4,
    in0.C_VARIANT_5 AS C_VARIANT_5,
    in0.C_STR_UTILS AS C_STR_UTILS
  
  FROM Reformat_1 AS in0
  INNER JOIN Reformat_2 AS in1
     ON in0.C_STR_UTILS != in1.C_STR_UTILS

),

SQLStatement_1 AS (

  SELECT 
    t1.c_int1,
    t1.c_int2,
    t1.c_string
  
  FROM (
    SELECT *
    
    FROM (
      SELECT 
        seq2(0) AS c_int1,
        seq1(1) AS c_int2,
        randstr(5, random()) AS c_string
      
      FROM table(generator(rowCount => 132))
     )
    
    ORDER BY seq2(0)
    
    LIMIT 100
    
    OFFSET 25
   ) AS t1
  
  WHERE t1.c_int1 > (
    SELECT count(*)
    
    FROM tpcds_1_env_uitesting_shared
   )

),

combine_multiple_tables_1 AS (

  {{ SQL_SnowflakeSharedBasic.combine_multiple_tables(table_1 = 'Join_1', table_2 = 'SQLStatement_1', table_3 = 'Aggregate_1', table_4 = 'Join_3', table_5 = 'Join_4', col_table_1 = 'c_int') }}

)

SELECT *

FROM combine_multiple_tables_1
