require 'aws-sdk'
require 'net/http'
require 'net/https'
require 'uri'
config_file '/properties.yml'

get '/getEnvironmentBadge' do
	elasticbeanstalk = Aws::ElasticBeanstalk::Client.new(
		region: settings.aws.region,
	  	access_key_id: settings.aws.access_key_id,
  	  	secret_access_key: settings.aws.secret_access_key)
  	ebsResp = elasticbeanstalk.describe_environments(environment_ids: [settings.aws.environment.id])	
  		
	envName = ebsResp.environments.first.environment_name.gsub! '-', '_'
  	envStatus = ebsResp.environments.first.status.downcase.capitalize 
  	envHealth = ebsResp.environments.first.health.downcase
  	envAppVersion = ebsResp.environments.first.version_label[0,10] 
 	
	uri = URI.parse("http://img.shields.io/badge/" + envName + "-" +envStatus+ "_Version_" + envAppVersion + "-" + envHealth + ".svg")
	http = Net::HTTP.new(uri.host, uri.port)
	
	imgrequest = Net::HTTP::Get.new(uri.request_uri)
	imgresponse = http.request(imgrequest)
    content_type 'image/svg+xml'
	cache_control settings.options.cachecontrol
	imgresponse.body             # => The body (HTML, XML, blob, whatever)  
end