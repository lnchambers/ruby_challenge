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

  def violation_types
    @full_data.map do |row|
      row[:violation_type]
    end.uniq
  end

  def count_for_violation_types
    violation_types.reduce({}) do |result, violation|
      result[violation] = @full_data.count do |row|
        row[:violation_type] == violation
      end
      result
    end
  end

  def date_of_earliest_violation
    violation_types.reduce({}) do |result, violation|
      result[violation] = @full_data.min_by do |row|
        row[:violation_date]
      end
      result
    end
  end

  def date_of_latest_violation
    violation_types.reduce({}) do |result, violation|
      result[violation] = @full_data.max_by do |row|
        row[:violation_date]
      end
      result
    end
  end

end
