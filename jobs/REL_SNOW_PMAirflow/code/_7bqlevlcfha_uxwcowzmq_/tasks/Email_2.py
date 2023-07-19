def Email_2():
    settings = {}
    from airflow.operators.email import EmailOperator
    from datetime import timedelta

    return EmailOperator(
        task_id = "Email_2",
        to = "abhisheks@propehcy.io",
        subject = "Test Airflow",
        html_content = "Test Airflow",
        cc = "navneet@prophecy.io",
        bcc = None,
        mime_subtype = "mixed",
        mime_charset = "utf-8",
        conn_id = "M5banLoWc5-970zwOKU3V",
        **settings
    )
