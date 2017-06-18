module AppliancesHelper


  def get_text(number)
    if number == 1
      return "1 kus"
    elsif number >= 2 && number <= 4
      return "#{number} kusy"
    else
      return "#{number} kusov"
    end
  end

end
