class CreditcardController < ApplicationController
  def index
  end
  
  
  def validate_card
    #get card number and card type and clean up any none digits
    card_number  = params[:credit_card].gsub(/\D/, '')
    card_type    = params[:credit_card_type]
     
   #initialize is_valid to false
    is_valid     = false
    
    case card_type
    when "master_card"
      is_valid = true if card_number.match(/^5[1-5][0-9]{14}$/)
      Rails.logger.debug("ITS VALID AND ITS MASTER")
    when "visa"
      is_valid = true if card_number.match(/^4[0-9]{12}(?:[0-9]{3})?$/)  
    when "amax"
      is_valid = true if card_number.match(/^3[47][0-9]{13}$/) 
    when "discover"
      is_valid = true if card_number.match(/^6(?:011|5[0-9]{2})[0-9]{12}$/)
    end
    
    #initialize
    total = 0;
    numbers = []

    #check if the sum of everyother number + remaining numbers can be divided by 10.
    card_number.split("").reverse.each_with_index  do |number,index|  
      number = number.to_i * 2 if index.odd?
      numbers << number.to_i
    end
    numbers.collect {|i| total+=i }
    is_valid = true if total % 10 == 0
    
    respond_to do |format|
       if is_valid
         flash[:success] = "Congrats your card is valid,"
       else 
         flash[:error] = "This is an invalid card please try again."
       end 
       format.html { redirect_to "/"}  
    end
  end
end
