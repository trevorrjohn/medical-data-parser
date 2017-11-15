class VitalsController < ApplicationController
  def show
    @vitals_panel = VitalsPanel.new
  end
end
