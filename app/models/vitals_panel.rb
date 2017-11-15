class VitalsPanel

  def first_vital_key
    vitals_hash['vitals'].first['abbreviation']
  end

  private

  def vitals_file
    @vitals_file ||= File.read('config/vitals.json')
  end

  def vitals_hash
    @vitals_hash ||= JSON.parse(vitals_file)
  end
end
