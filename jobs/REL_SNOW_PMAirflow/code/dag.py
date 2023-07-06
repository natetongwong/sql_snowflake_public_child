import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from _7bqlevlcfha_uxwcowzmq_.tasks import DBT_0_2, DBT_0_2_1, Email_2, HTTPSensor_1, S3FileSensor_1, Slack_1
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "_7BQLEVlcFHA_uxwCoWZMQ_", 
    schedule_interval = "0 0 17 * *", 
    default_args = {"owner" : "Prophecy", "ignore_first_depends_on_past" : True, "do_xcom_push" : True, "pool" : "n7pJN9mh"}, 
    start_date = pendulum.today('UTC'), 
    end_date = pendulum.datetime(2023, 7, 11, tz = "UTC"), 
    catchup = True
) as dag:
    Slack_1_op = Slack_1()
    HTTPSensor_1_op = HTTPSensor_1()
    S3FileSensor_1_op = S3FileSensor_1()
    DBT_0_2_1_op = DBT_0_2_1()
    Email_2_op = Email_2()
    DBT_0_2_op = DBT_0_2()
    DBT_0_2_op >> [DBT_0_2_1_op, HTTPSensor_1_op, S3FileSensor_1_op]
    S3FileSensor_1_op >> Slack_1_op
    HTTPSensor_1_op >> Email_2_op
