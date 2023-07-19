import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
from airflow.models.param import Param
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from uitesting_shared_team_sql_snowflakesharedbasic_rel_snow_airflow.tasks import DBT_0, DBT_0_2, Script_1, Script_2
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "uitesting_shared_team_SQL_SnowflakeSharedBasic_REL_SNOW_AIRFLOW", 
    schedule_interval = "0 0 17 * *", 
    default_args = {
      "owner": "Prophecy", 
      "email": "abhisheks@prophecy.io,abhisheks@simpledatalabs.com", 
      "email_on_failure": True, 
      "retry_exponential_backoff": True, 
      "retries": 1, 
      "execution_timeout": timedelta(seconds = 1), 
      "max_retry_delay": timedelta(minutes = 2.0), 
      "retry_delay": timedelta(minutes = 2.0), 
      "trigger_rule": "all_done", 
      "depends_on_past": True, 
      "ignore_first_depends_on_past": True, 
      "wait_for_downstream": True, 
      "do_xcom_push": True, 
      "priority_weight": 1, 
      "weight_rule": "absolute", 
      "pool": "testAutomationPool", 
      "pool_slots": 2
    }, 
    start_date = pendulum.datetime(2023, 1, 1, tz = "Pacific/Midway"), 
    end_date = pendulum.datetime(2080, 1, 1, tz = "Pacific/Midway"), 
    catchup = True, 
    dagrun_timeout = timedelta(seconds = 3600), 
    max_active_runs = 28, 
    max_active_tasks = 2, 
    tags = ["rel_snow_airflow", "snowflake"]
) as dag:
    Script_1_op = Script_1()
    DBT_0_op = DBT_0()
    Script_2_op = Script_2()
    DBT_0_2_op = DBT_0_2()
    DBT_0_op >> [Script_1_op, Script_2_op]
    Script_1_op >> DBT_0_2_op
