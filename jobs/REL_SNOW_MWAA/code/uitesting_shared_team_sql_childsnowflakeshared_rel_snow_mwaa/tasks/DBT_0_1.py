def DBT_0_1():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_PRINTER_WIDTH"] = "100"
    envs["DBT_PROFILES_DIR"] = "/usr/local/airflow/dags"
    envs["DBT_SEND_ANONYMOUS_USAGE_STATS"] = "false"
    envs["DBT_FAIL_FAST"] = "true"
    envs["DBT_LOG_PATH"] = "logssnow.txt"
    envs["DBT_FULL_REFRESH"] = "true"

    return BashOperator(
        task_id = "DBT_0_1",
        bash_command = "set -euxo pipefail; tmpDir=`mktemp -d`; git clone https://github.com/abhisheks-prophecy/sql_snowflake_public_child_1 --branch dev --single-branch $tmpDir; cd $tmpDir/; dbt -r output.profile deps --profile run_profile_snowflake; dbt -r output.profile seed --profile run_profile_snowflake --threads=2 --exclude env_uitesting_shared_excluded_model; dbt -r output.profile run --profile run_profile_snowflake --threads=2 --exclude env_uitesting_shared_excluded_model; ",
        env = envs,
        append_env = True,
        email = "abhisheks@prophecy.io", 
        email_on_failure = True, 
        email_on_retry = False, 
        retry_exponential_backoff = True, 
        retries = 1, 
        execution_timeout = timedelta(seconds = 3600), 
        max_retry_delay = timedelta(minutes = 1.0), 
        retry_delay = timedelta(minutes = 1.0), 
        trigger_rule = "always"
    )
