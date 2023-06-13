def DBT_0_2():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}
    envs["DBT_PRINTER_WIDTH"] = "100"
    envs["DBT_SEND_ANONYMOUS_USAGE_STATS"] = "false"
    envs["DBT_FAIL_FAST"] = "true"
    envs["DBT_LOG_PATH"] = "logssnow.txt"
    envs["DBT_FULL_REFRESH"] = "true"

    if "Cautious":
        envs["DBT_INDIRECT_SELECTION"] = "Cautious"

    envs["DBT_PROFILE_SECRET"] = "hwcTnR9DmvB6YVPYFtkxa"
    envs["GIT_TOKEN_SECRET"] = ""
    envs["GIT_ENTITY"] = "branch"
    envs["GIT_ENTITY_VALUE"] = "dev"
    envs["GIT_SSH_URL"] = "https://github.com/abhisheks-prophecy/sql_snowflake_public_child_1"
    envs["GIT_SUB_PATH"] = ""

    return BashOperator(
        task_id = "DBT_0_2",
        bash_command = f"$PROPHECY_HOME/run_dbt.sh \"dbt -r output.profile deps --profile run_profile; dbt -r output.profile seed --profile run_profile --threads=2 --exclude env_uitesting_shared_excluded_model; dbt -r output.profile run --profile run_profile --threads=2 --exclude env_uitesting_shared_excluded_model; \"",
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
