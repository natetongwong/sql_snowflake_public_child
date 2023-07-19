def Slack_1():
    settings = {}
    from airflow.providers.slack.operators.slack import SlackAPIPostOperator
    from datetime import timedelta

    return SlackAPIPostOperator(
        task_id = "Slack_1",
        text = "Test Slack Snow PM",
        channel = "abhyslackpub",
        slack_conn_id = "7k_Cby3g6vOgeKrdy93nb",
        **settings
    )
