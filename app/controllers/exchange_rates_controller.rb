class ExchangeRatesController < ApplicationController

  def index
      if ExchangeRate.take
        redirect_to '/conversions/new'
      else
        response = HTTParty.get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
        data = response.parsed_response
        data['Envelope']['Cube']['Cube'].each do |i|
          date = i['time']
          i['Cube'].each do |j|
            record = ExchangeRate.new
            record.base = 'EUR'
            record.counter = j['currency'].to_s
            record.rate = j['rate'].to_f
            record.date = Date.parse(date)
            record.save
          end
        end
        redirect_to '/conversions/new'
      end
    end

end
