class VitalsApi
  include Singleton

  def self.fetch
    instance.vitals
  end

  def vitals
    @vitals ||= JSON.parse(vitals_file)
  end

  private

  def vitals_file
    @vitals_file ||= File.read('config/vitals.json')
  end
end
