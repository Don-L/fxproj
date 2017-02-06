class ConversionsController < ApplicationController

  def index
  end

  def new
    @currencies = ExchangeRate.all_currencies
    # puts 'heeeeeey ' + params[:conversion][:amount]
    # redirect_to "/conversions/show/2017-02-01/#{params[:conversion][:base]}/#{params[:conversion][:counter]}/#{params[:conversion][:amount]}"
  end

  def show
    # date = Date.parse(params[:date])
    date = Date.parse('2017-02-01')
    if params[:conversion]
      @base = params[:conversion][:base]
      @counter = params[:conversion][:counter]
      @amount = params[:conversion][:amount]
    else
      @base = params[:base]
      @counter = params[:counter]
      @amount = params[:amount]
    end
    @conversion = Conversion.new(date, @base, @counter, @amount)
    @converted_amount = sprintf('%.2f', @conversion.converted_amount)
    @rate = sprintf('%.4f', @conversion.rate)
    @currencies = ExchangeRate.all_currencies
  end



end
