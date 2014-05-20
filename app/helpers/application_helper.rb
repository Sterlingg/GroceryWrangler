module ApplicationHelper
  def string_to_int_or_float(str)
    # Parses a string into an int if possible, otherwise
    # turns it into a float.
      Integer(str) rescue Float(str)
  end

  def price_string_format(string)
    sprintf("%.2f", string.to_s)
  end
end
