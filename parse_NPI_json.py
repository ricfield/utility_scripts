import urllib.request, json

postal_code = input("Enter Postal Code: ")
last_name = input("Enter Last Name: ")

nppes_url = urllib.request.urlopen("https://npiregistry.cms.hhs.gov/api/?limit=200&number=&enumeration_type=1&taxonomy_description=&last_name=" + last_name + "&firstname=&postal_code=" + postal_code)

pv_information_json = json.loads(nppes_url.read())

print("\n\nResults:\n")
      
for pv in pv_information_json['results']:
   print("\nDoctor Name: " + pv['basic']['first_name'],pv['basic']['last_name'] + "\nNPI Number: " + str(pv['number']))

print("\n")
