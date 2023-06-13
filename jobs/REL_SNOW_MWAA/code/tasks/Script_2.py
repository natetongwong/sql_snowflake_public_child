def Script_2():
    settings = {}
    from datetime import timedelta
    from airflow.operators.bash import BashOperator

    return BashOperator(task_id = "Script_2", bash_command = "ls -ltr", **settings)
