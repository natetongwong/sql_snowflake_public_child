def DBT_1():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {}

    return BashOperator(
        task_id = "DBT_1",
        bash_command = (
          f"{"set -euxo pipefail; tmpDir=`mktemp -d`; git clone " + f" --branch {None} --single-branch $tmpDir"}; cd $tmpDir/; "
          + "dbt"
          + " run"
          + "; "
          + "dbt"
          + " test"
          + "; "
        ),
        env = envs,
        append_env = True,
        **settings
    )
