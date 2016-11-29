require 'rubygems'
require 'active_support/all'
require 'rest_client'



class WeatherController < ApplicationController
  def getWeather
    
  end
  
  def home
    key = 'vaI1b54%2FQkCb1BV1aURo2hC%2FMtpgxRqLiQ5%2F%2BbeJtmDSTPeOD1Tnp5qFGsfp0UiFh4kktGY%2B1f3myCjoV9uYFQ%3D%3D'
    url = 'http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData'
    queryParams = '?' + 'base_date=' + '20161124' + '&base_time='+'1400'+'&nx='+'100'+'&ny='+'84'+'&serviceKey=' + key
    wholeurl = url+queryParams
    
    RestClient.get(wholeurl){ |response, request, result, &block|
    	case response.code
    	when 200
    		re = Hash.from_xml(response).to_json
    		@res = JSON.parse(re)
    
    		# print(res)
    		# print("\n")
    		# print(res['response']['body']['items']['item'])
    		# print("\n")
    	when 423
    		raise SomeCustomExceptionIfYouWant
    	else
    		response.return!(request, result, &block)
    	end
    }

    
    
    
    
    
    
  end
  
  
  
  
  
  
end
