require 'aws-sdk'
require 'net/http'
require 'net/https'
require 'uri'

get '/getEnvironmentBadge' do
	elasticbeanstalk = Aws::ElasticBeanstalk::Client.new(
		region: 'us-west-2',
	  	access_key_id: 'AKIAJU3P2SJCH5UOBDXA',
  	  	secret_access_key: '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')
  	ebsResp = elasticbeanstalk.describe_environments(environment_ids: ["e-y2xhmkgxqf"])	
  		
	envName = ebsResp.environments.first.environment_name.gsub! '-', '_'
  	envStatus = ebsResp.environments.first.status.downcase.capitalize 
  	envHealth = ebsResp.environments.first.health.downcase
  	envAppVersion = ebsResp.environments.first.version_label[0,10] 
 	
	uri = URI.parse("http://img.shields.io/badge/" + envName + "-" +envStatus+ "_Version_" + envAppVersion + "-" + envHealth + ".svg")
	http = Net::HTTP.new(uri.host, uri.port)
	
	imgrequest = Net::HTTP::Get.new(uri.request_uri)
	imgresponse = http.request(imgrequest)
    content_type 'image/svg+xml'
	cache_control 'no-cache'
	imgresponse.body             # => The body (HTML, XML, blob, whatever)  
end