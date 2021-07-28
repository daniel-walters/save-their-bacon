class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :check_approved, only: [:new, :edit, :destroy]
  before_action :get_categories, only: [:index]

  # GET /animals or /animals.json
  def index
    if params[:category]
      @animals = Animal.where(category_id: params[:category])
    else
      @animals = Animal.all
    end
  end

  # GET /animals/1 or /animals/1.json
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals or /animals.json
  def create
    @animal = Animal.new(animal_params)
    @animal.owner = current_user

    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: "Animal was successfully created." }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1 or /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: "Animal was successfully updated." }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1 or /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url, notice: "Animal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.includes(:owner, :category).find(params[:id])
    end

    def get_categories
      @categories = Category.all
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :year_born, :weight, :bio, :species, :sponsored, :sponsor_price, :category_id, :owner_id, :profile_picture, media: [])
    end

    def check_approved
      redirect_to animals_path, notice: "Your account is not yet approved, you can't list an animal." if !current_user.approved?
    end
end
