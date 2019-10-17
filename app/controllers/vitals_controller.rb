class VitalsController < ApplicationController
  def show
    @vitals = VitalsApi.fetch["vitals"]
    @presenter = VitalsPresenter.new(@vitals)
  end
end
