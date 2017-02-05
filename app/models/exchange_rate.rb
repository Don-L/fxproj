class ExchangeRate < ApplicationRecord

  def self.at(date, base, counter)
    if base == counter
      return 1.00
    end
    if base == 'EUR' || counter == 'EUR'
      if base == 'EUR'
        record = self.find_by date: date, counter: counter
        return record.rate
      end
      if counter == 'EUR'
        record = self.find_by date: date, counter: base
        return 1 / record.rate
      end
    else
      self.at_cross(date, base, counter)
    end
  end

  def self.at_cross(date, base, counter)
    record1 = self.find_by date: date, base: 'EUR', counter: base
    record2 = self.find_by date: date, base: 'EUR', counter: counter
    rate1 = record1.rate
    rate2 = record2.rate
    return rate2 / rate1
  end

end
