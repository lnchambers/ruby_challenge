require "csv"

class CSVReader

  attr_reader :full_data

  def initialize(file)
    @full_data = []
    read_csv(file)
  end

  def read_csv(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      @full_data << row
    end
  end

  def count_for_refuse_accumulation
    @full_data.count do |row|
      row[:violation_type] == "Refuse Accumulation"
    end
  end

  def count_for_unsanitary_conditions
    @full_data.count do |row|
      row[:violation_type] == "Unsanitary conditions, not specified"
    end
  end

end
