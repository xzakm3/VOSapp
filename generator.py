#!/usr/bin/python

import psycopg2
import hashlib
import datetime
import time
import string
import random
from faker import Faker

cur = 0
conn = 0

def generate_text():
    message = ""
    for i in (0,11):
        message += random.choice(string.letters)
    return message

conn = 0
try:
    conn = psycopg2.connect("dbname='myapp_development' user='martin' host='localhost' password='Dominecko1'")
    print "---Connected---"
    conn.autocommit = True
except:
    print "I am unable to connect to the database"

if conn:
    cur = conn.cursor()
    try:
        data = [("njhdfo@gmail.com", "adfasdarafaezxf6wngklsjfhw", "2017-03-23 11:01:38", "2017-03-23 11:01:38", "awerfisd"), ("pqwevdja@gmail.com", "adfasrvtujsfvsacavasd", "2017-03-23 11:01:38", "2017-03-23 11:01:38", "qgasfva")]
        user = ("asfklj@gmail.com", "qworiucweuivnvohcnapfeapcf", "2017-03-23 11:01:38", "2017-03-23 11:01:38", "alezalova")
        data.append(user)
        args_str = ','.join(cur.mogrify("(%s,%s,%s,%s,%s)", x) for x in data)
        cur.execute("INSERT INTO users(email, heslo, created_at, updated_at, adresa) VALUES " + args_str)
        print "Inserted"
    except:
		print "Cannot insert"

    cur.close
    conn.close()
    print "---Disconnected---"

else:
    print "Nothing to disconnect"
