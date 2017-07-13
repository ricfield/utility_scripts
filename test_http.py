import ssl
import urllib

from http.client import HTTPSConnection

method = ""
path = ""
hostName = ""

# connect to HTTPS server without checking the certificate
conn01 = HTTPSConnection(hostName, context=ssl._create_unverified_context())

conn01.request(method, path)
response01 = conn01.getresponse()
response01.read()
