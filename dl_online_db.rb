require 'uri'
require 'net/http'

url = 'https://data.cityofnewyork.us/api/views/xx67-kt59/rows.json?accessType=DOWNLOAD'
target = "temper.json"
r = Net::HTTP.get_response(URI.parse(url).host, URI.parse(url).path)

File.open(target, "wb") do |output|
  while buff = r.read(4096)
    output.write(buff)
  end
end
