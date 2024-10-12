import pandas as pd
from kafka import KafkaProducer

if __name__ == '__main__':
    producer = KafkaProducer(bootstrap_servers='localhost:19092')
    topic = 'agent-reports'
    df = pd.read_csv('data/agent-reports-data.csv', names=['agent_id',
                                                           'real_estate_map_url',
                                                           'real_estate_type',
                                                           'real_estate_price'])
    for i, row in df.iterrows():
        str = f"{row.agent_id},{row.real_estate_map_url},{row.real_estate_type},{row.real_estate_price}"
        producer.send(topic=topic, value=str.encode())
