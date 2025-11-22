class FlatsController < ApplicationController
  before_action :get_flat, only: [:show, :edit, :update, :destroy]
  def index
    if params[:query].present?
      @query = params[:query]
      @flats = Flat.where("name LIKE ?", "%#{params[:query]}%")
      # Note: adding '?' to avoid SQL injection + database error on unknown chars.
    else
      @flats = Flat.all
    end
  end

  def show
    @flat
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to flats_path
    else
      render "flats/new", status: :unprocessable_entity
    end
  end

  def edit
    @flat
  end

  def update
    if @flat.update(flat_params)
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy

    redirect_to flats_path, status: :see_other
  end


  private

  def get_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :description, :address, :number_of_guests, :price_per_night, :image_url)
  end


end
