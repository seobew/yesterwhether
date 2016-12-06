require 'rubygems'
require 'active_support/all'
require 'rest_client'



class WeatherController < ApplicationController
  def getWeather
    
  end
  
  def home
    time = Time.new
    year = "#{time.year}"
    month = Pastwheather.addzero time.month
    day = Pastwheather.addzero time.day
    hour = Pastwheather.addzero time.hour
    
    date = year + month + day
    thistime = hour + "00"
    key = 'vaI1b54%2FQkCb1BV1aURo2hC%2FMtpgxRqLiQ5%2F%2BbeJtmDSTPeOD1Tnp5qFGsfp0UiFh4kktGY%2B1f3myCjoV9uYFQ%3D%3D'
    url = 'http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastGrib'
    queryParams = '?' + 'base_date='+ date + '&base_time='+ thistime +'&nx='+'100'+'&ny='+'84'+'&serviceKey=' + key
    wholeurl = url+queryParams
    
    # get weather data
    RestClient.get(wholeurl){ |response, request, result, &block|
    	case response.code
    	when 200
    		re = Hash.from_xml(response).to_json
    		res = JSON.parse(re)
				@temperature = res['response']['body']['items']['item'].find {|ite| ite['category'] =='T1H'}['obsrValue'].to_f
				sky_value = res['response']['body']['items']['item'].find {|ite| ite['category'] =='SKY'}['obsrValue'].to_i
				rain_status = res['response']['body']['items']['item'].find {|ite| ite['category'] =='PTY'}['obsrValue'].to_i
				rain_value = res['response']['body']['items']['item'].find {|ite| ite['category'] =='RN1'}['obsrValue'].to_i
				print("rain value = ")
				print(rain_value)
				print("\n")
				case rain_status
				when 0
					print("no rain\n")
				when 1
					print("rain\n")
					sky_value = 11
				when 2
					print("rain/snow\n")
					sky_value = 12
				when 3
					print("snow\n")
					sky_value = 13
				end
				case sky_value
				when 0..2
					@sky = "맑음"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB01.png"
				when 3..5
					@sky = "구름조금"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB02.png"
				when 6..8
					@sky = "구름많음"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB03.png"
				when 9..10
					@sky = "흐림"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB04.png"
				when 11
					@sky = "비"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB08.png"
				when 12
					@sky = "눈/비"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB12.png"
				when 13
					@sky = "눈"
					@sky_image = "http://www.kma.go.kr/images/icon/NW/NB11.png"
				end
    	when 423
    		raise SomeCustomExceptionIfYouWant
    	else
    		response.return!(request, result, &block)
    	end
    }
  end
end
