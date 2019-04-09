class StocksController < ApplicationController
	def search
		if params[:stock].blank? #To know if the search is empty
			flash.now[:danger]="You have entered on empty search string"
		else
			@stock = Stock.new_from_lookup(params[:stock])
			flash.now[:danger]='You have entered on incorrect symbol' unless @stock # To know if the stock symbol is good
	    end
	    respond_to do |format|
	    	format.js{ render partial: 'users/result'}
	   	end
	   	
	end
	def self.find_by_ticker(ticker_symbol)
    	where(ticker: ticker_symbol).first
  	end
end
