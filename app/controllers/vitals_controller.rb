class VitalsController < ApplicationController
  def show
    @vitals = VitalsApi.fetch["vitals"]
  end
end
