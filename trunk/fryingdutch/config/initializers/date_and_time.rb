module ActionView  
  module Helpers  
    module DateHelper  

      def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)  
        from_time = from_time.to_time if from_time.respond_to?(:to_time)  
        to_time = to_time.to_time if to_time.respond_to?(:to_time)  
        distance_in_minutes = (((to_time - from_time).abs)/60).round  
        distance_in_seconds = ((to_time - from_time).abs).round  
      
        case distance_in_minutes  
          when 0..1  
            return (distance_in_minutes == 0) ? 'minder dan een minuut' : '1 minuut' unless include_seconds  
            case distance_in_seconds  
              when 0..4   then 'minder dan 5 seconden'  
              when 5..9   then 'minder dan 10 seconden'  
              when 10..19 then 'minder dan 20 seconden'  
              when 20..59 then 'minder dan een minuut'  
              else             '1 minuut'  
            end  
          when 2..44           then "#{distance_in_minutes} minuten"
          when 45..89          then 'ongeveer 1 uur'
          when 90..1439        then "ongeveer #{(distance_in_minutes.to_f / 60.0).round} uur"
          when 1440..2879      then '1 dag'
          when 2880..43199     then "#{(distance_in_minutes / 1440).round} dagen"
          when 43200..86399    then 'ongeveer 1 maand'
          when 86400..525959   then "#{(distance_in_minutes / 43200).round} maanden"
          when 525960..1051919 then 'ongeveer 1 jaar'
          else                      "meer dan #{(distance_in_minutes / 525960).round} jaar"
        end
      end
    end
  end
end