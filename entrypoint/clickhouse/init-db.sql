CREATE DATABASE IF NOT EXISTS redpanda_warehouse;

CREATE TABLE IF NOT EXISTS redpanda_warehouse.agent_reports
(
    agent_id UInt64,
    real_estate_map_url String,
    real_estate_type String,
    real_estate_price Float32
) ENGINE = Kafka()
SETTINGS
    kafka_broker_list = 'redpanda-0:9092',
    kafka_topic_list = 'agent-reports',
    kafka_group_name = 'clickhouse-group',
    kafka_format = 'CSV';

CREATE MATERIALIZED VIEW redpanda_warehouse.agent_reports_view
ENGINE = Memory
AS
SELECT * FROM redpanda_warehouse.agent_reports
SETTINGS
stream_like_engine_allow_direct_select = 1;