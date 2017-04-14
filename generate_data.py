#!/usr/bin/python
import urllib
import psycopg2
import hashlib
import datetime
import time
import string
import random
import urllib2
import re
from bs4 import BeautifulSoup
from faker import Faker

poc = 1
cur = 0
conn = 0
range4 = range(1,1000)
range1 = range(2000,2017)
range2 = range(1,9)
range3 = range(11,27)

def duplicate(names):
    names.append('AlfonzoHybrid')
    names.append('Frantisekovsak')
    names.append('Miloslavius')
    names.append('Caesariusovak')
    names.append('Jokeice')
    dlzka = len(names)
    return names

def generate_text(length):
    message = ""
    for i in (0,length):
        message += random.choice(string.letters)
    return message

def generuj_registracie():
    global cur, conn, poc
    regs = []
    fake = Faker()
    i = 1
    while (i<5000):            #este pojdem 90 000 aby som mal 200 000
        user = poc
        d = random.sample(range4,1)
        dodavatel = d[0]
        y = random.sample(range1,1)
        year = y[0]
        m = random.sample(range2,1)
        month = m[0]
        d = random.sample(range3,1)
        day = d[0]
        times = str(year)+"-0"+str(month)+"-"+str(day)
        reg = (user, dodavatel, times)
        regs.append(reg)
        i += 1
        poc += 1
    return regs
###################################################MAIN FUNCTION##############################################
conn = 0
try:
    conn = psycopg2.connect("dbname='myapp_development' user='martin' host='localhost' password='Dominecko1'")
    print "---Connected---"
    conn.autocommit = True
except:
    print "I am unable to connect to the database"

if conn:
    dlzka_dat = 0
    i = 0

    cur = conn.cursor()
    try:
        while(i < 1000):
            data = generuj_registracie()
            dlzka_dat += len(data)+1
            args_str = ""
            args_str = ','.join(cur.mogrify("(%s,%s,%s)", x) for x in data)
            cur.execute("INSERT INTO registracia_u_dodavatelas(user_id, dodavatel_id, od) VALUES " + args_str)
            print str(i+1) + "------------------------------------INSERTED " + str(dlzka_dat) + " zaznamov-----------------------"
            i += 1
    except:
        print "Cannot insert"
if conn:
    cur.close()
    conn.close()
    print "---Disconnected---"
else:
    print "Nothing to disconnect"














JOIN
	(SELECT ci.name, max(temperature) as temperature FROM Cities ci
	JOIN Sensors s ON s.city_id = ci.id
	JOIN Measurements m ON m.sensor_id = s.id
	GROUP BY (ci.id)) temp
ON cit.name = temp.name