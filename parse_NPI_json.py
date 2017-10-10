import urllib.request, json, csv, sys

nppes_url = urllib.request.urlopen("https://npiregistry.cms.hhs.gov/api/?number=&enumeration_type=&taxonomy_description=&first_name=&last_name=&state=&postal_code=21152")

pv_information_json = json.loads(nppes_url.read())

csv_file_writer = csv.writer(sys.stdout)

for pv in pv_information_json['results']:
   csv_file_writer.writerow(pv['results'])

