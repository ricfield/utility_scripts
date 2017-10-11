import urllib.request, json, csv, sys

nppes_url = urllib.request.urlopen("https://npiregistry.cms.hhs.gov/api/?number=&enumeration_type=&taxonomy_description=&last_name=SMITH&firstname=&state=MD&postal_code=")

pv_information_json = json.loads(nppes_url.read())

for pv in pv_information_json['results']:
   print(pv['basic']['name'],pv['number'])
