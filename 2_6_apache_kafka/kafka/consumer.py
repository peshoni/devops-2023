
# TBD
# ASSIGN to given partition of topic

from kafka import KafkaConsumer
print('Consumer started. Press Ctrl+C to stop.')
try:
    consumer = KafkaConsumer(bootstrap_servers=['kafka:9092'])
    consumer.subscribe(['topic1'])
    for message in consumer:
        print(message)
except Exception as ex:
 print(str(ex))
except KeyboardInterrupt:
 pass
finally:
    if consumer is not None:
        consumer.close()
print('... closed.')
