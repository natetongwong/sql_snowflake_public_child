def S3FileSensor_1():
    settings = {}
    from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor

    return S3KeySensor(
        task_id = "S3FileSensor_1",
        bucket_key = [s.strip() for s in "test/validation_data/test_source.json".split(",") if s.strip()],
        bucket_name = "qa-prophecy",
        check_fn = None,
        aws_conn_id = "3hP6KE_YNA1BFStS3sBTI",
        wildcard_match = False,
        verify = False,
        **settings,
    )
