class ConvertString
  class << self
    def get_prefix_code str
      index = 0
      str.strip.split("").each_with_index do |value, i|
        temp = Integer(value) rescue false
        if temp.is_a? Numeric
          index = i
          break
        end
      end
      str.slice(0, index)
    end
  end
end
