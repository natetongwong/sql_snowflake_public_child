def HTTPSensor_1():
    settings = {}
    from airflow.providers.http.sensors.http import HttpSensor
    from datetime import timedelta

    return HttpSensor(
        task_id = "HTTPSensor_1",
        endpoint = "/webhp",
        request_params = None,
        response_check = None,
        http_conn_id = "qg4zfoFh98cOx-J9Zkgyt",
        poke_interval = 5,
        **settings,
    )
