import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from tasks import DBT_0, Script_1, Script_2
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "uitesting_shared_team_SQL_SnowflakeSharedBasic_REL_SNOW_AIRFLOW", 
    schedule_interval = "0 0 17 * *", 
    default_args = {
      "owner": "Prophecy", 
      "retry_exponential_backoff": True, 
      "retries": 1, 
      "max_retry_delay": timedelta(minutes = 2.0), 
      "retry_delay": timedelta(minutes = 2.0), 
      "ignore_first_depends_on_past": True, 
      "do_xcom_push": True
    }, 
    start_date = pendulum.datetime(2023, 1, 1, tz = "Pacific/Midway"), 
    end_date = pendulum.datetime(2080, 1, 1, tz = "Pacific/Midway"), 
    catchup = True, 
    tags = ["rel_snow_airflow", "snowflake"]
) as dag:
    DBT_0_op = DBT_0()
    Script_1_op = Script_1()
    Script_2_op = Script_2()
    DBT_0_op >> Script_1_op
    Script_1_op >> Script_2_op
