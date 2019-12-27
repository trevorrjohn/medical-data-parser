class VitalsPresenter
  def initialize(vitals)
    @vitals = vitals
  end

  def temperature
    @temperature ||= get_readings("T", "VITALS.TEMPERATURE", nil)
  end

  def heart_rate
    @heart_rate ||= get_readings("HR", "VITALS.HEARTRATE", nil)
  end

  def blood_pressure
    @blood_pressure ||= get_readings("BP", "VITALS.BLOODPRESSURE.SYSTOLIC", "VITALS.BLOODPRESSURE.DIASTOLIC", "mmHg")
  end

  private

  attr_reader :vitals

  def get_readings(abbreviation, numerator_key, denominator_key, unit_override = nil)
    raw = abbreviation(abbreviation)["readings"]
    unit = unit_override || raw.first.first["unit"]
    readings = raw.flat_map do |reading_array|
      {
        date: reading_array.first["createddate"],
        numerator: get_reading(reading_array, numerator_key),
        denominator: denominator_key.present? ? get_reading(reading_array, denominator_key) : nil,
      }
    end

    OpenStruct.new(label: abbreviation, unit: unit, readings: readings.last(3).reverse)
  end

  def get_reading(reading_array, element_value)
    reading_array.detect { |x| x["clinicalelementid"] == element_value}&.fetch("value", nil)
  end

  def abbreviation(abbreviation)
    vitals.detect {|x| x["abbreviation"] == abbreviation }
  end
end
