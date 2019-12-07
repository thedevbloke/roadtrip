class AddressesController < ApplicationController
  before_action :set_location
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @address = @location.build_address()
    render partial: 'form'
  end

  def create
    @address = @location.build_address(address_params)
    if @address.save
      redirect_to trip_location_path(@location.trip_id, @location)
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to trip_location_path(@location.trip_id, @location)
    else
      render :edit
    end
  end

  def edit
    render partial: "form"
  end

  def destroy
    @location.destroy
    redirect_to trip_locations_path(@trip)
  end

  private
    def set_location
      @location = Location.find(params[:location_id])
    end

    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:street, :city, :state, :zip)
    end
end
