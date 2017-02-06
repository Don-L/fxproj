class ExchangeRatesController < ApplicationController

  def index
    if ExchangeRate.take
      redirect_to '/conversions/new'
    else
      response = HTTParty.get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
      data = response.parsed_response
      attributes = []
      data['Envelope']['Cube']['Cube'].each do |i|
        date = i['time']
        i['Cube'].each do |j|
          attributes.push({base: 'EUR',
                           counter: j['currency'].to_s,
                           rate: j['rate'].to_f,
                           date: Date.parse(date)})
        end
      end
      ExchangeRate.create(attributes)
      redirect_to '/conversions/new'
    end
  end

end
