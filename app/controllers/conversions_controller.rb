class ConversionsController < ApplicationController

  def index
  end

  def new
  end

  def show
    date = Date.parse(params[:date])
    base = params[:base]
    counter = params[:counter]
    amount = params[:amount].to_f
    conversion = Conversion.new(date, base, counter, amount)
    @converted_amount = conversion.converted_amount.to_s
    @rate = conversion.rate.to_s
  end

end
