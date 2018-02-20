require "./test/test_helper"
require "./lib/csv_reader.rb"

class CSVReaderTest < Minitest::Test

  def test_csv_reader_exists
    csv = CSVReader.new("./lib/data/code_violations.csv")

    assert_instance_of CSVReader, csv
  end

  def test_csv_reader_has_the_correct_attributes
    csv = CSVReader.new("./lib/data/code_violations.csv")

    assert_instance_of Array, csv.full_data
  end

  def test_csv_reader_can_read_csvs
    csv = CSVReader.new("./lib/data/code_violations.csv")

    assert_instance_of CSV::Row, csv.full_data[0]
    assert_equal "204852", csv.full_data[1][:violation_id]
  end

  def test_count_for_violation_types
    csv = CSVReader.new("./lib/data/code_violations.csv")

    assert_equal 106, csv.count_for_violation_types("Refuse Accumulation")
  end

  def test_date_of_earliest_violation
    csv = CSVReader.new("./lib/data/code_violations.csv")

    assert_instance_of Hash, csv.date_of_earliest_violation
    assert_equal "2012-01-03 00:00:00", csv.date_of_earliest_violation["Refuse Accumulation"][:violation_date]
  end

  def test_date_of_latest_violation
    csv = CSVReader.new("./lib/data/code_violations.csv")

    assert_instance_of Hash, csv.date_of_earliest_violation
    assert_equal "2012-12-28 00:00:00", csv.date_of_latest_violation["Refuse Accumulation"][:violation_date]
  end

end
