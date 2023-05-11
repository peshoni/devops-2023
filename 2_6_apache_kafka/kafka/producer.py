from kafka import KafkaProducer
from time import sleep
import random

# Random text generator
word_length = 10
words = 5
source = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

def get_random_string(len):
    out=''
    for x in range(len):
        out += source[random.randrange(25)]
    return out     
 
def get_random_sentence(): # a little bit encoded but..
    out=''
    for y in range(words):
        out+= get_random_string(word_length)+' '
    return out.strip()
 
# end Random text generator

topic = 'topic1' 


print('Producer started. Press Ctrl+C to stop. Working on topic =' + topic)

try:
    producer = KafkaProducer(bootstrap_servers=['kafka:9092'])
    while True:
        sentence = get_random_sentence()
        print('message: ' + sentence)
        producer.send(topic, bytes(sentence, encoding='utf-8'))
        producer.flush()
        seconds = random.randrange(1,10)
        print('Sleep for ' + str(seconds) + ' second(s).')
        sleep(seconds)
except Exception as ex:
    print(str(ex))
except KeyboardInterrupt:
    pass
finally:
    if producer is not None:
        producer.close()
 
print('... closed.')