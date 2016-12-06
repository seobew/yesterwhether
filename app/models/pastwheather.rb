class Pastwheather < ActiveRecord::Base
    def self.addzero a
        if a<10
            b = "0#{a}"            
            return b
        else
            b = "#{a}"
            return b
        end
    end
    
    def self.compare yesterday, theseday
        if yesterday.temperature - theseday.temperature > 3
            puts "it's cold than yesterday"            
        elsif theseday.temperature - yesterday.temperature > 3
            puts "it's warm than yesterday"
        else
            puts "it's like yesterday"
        end
        
    end
end
