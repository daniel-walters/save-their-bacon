class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show edit update destroy media_add media_delete new_message]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :check_approved, only: [:new, :edit, :destroy]
  before_action :redirect_sponsor, only: [:new, :edit, :destroy]
  before_action :get_categories, only: [:index, :new, :edit]
  before_action :check_ownership, only: [:edit, :delete]

  # GET /animals or /animals.json
  def index
    @animals = Animal.all
    if params[:category]
      if @categories.all.map {|c| c.id}.include? params[:category].to_i
        @animals = @animals.where(category_id: params[:category])
      end
    end
    if params[:sponsored]
      case params[:sponsored]
      when "0"
        @animals = @animals.where(sponsored: false)
      when "1"
        @animals = @animals.where(sponsored: true)
      end
    end
    if params[:name]
      if !params[:name].empty?
        @animals = @animals.where("name like ?", "%#{params[:name].downcase}%")
      end
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

  def media_add
    params[:media]&.each do |img|
      @animal.media.attach img
    end
    redirect_back(fallback_location: animal_path(@animal))
  end

  def media_delete
    @animal.media.find(params[:media_id]).purge
    redirect_back(fallback_location: animal_path(@animal))
  end

  def new_message
    Message.create(body: params[:message], sender_id: current_user.id, chat_id: @animal.sponsorship.chat.id)
    redirect_back(fallback_location: animal_path(@animal))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.includes(:owner, :category).find(params[:id])
    end

    def get_categories
      @categories = Category.all
    end

    def redirect_sponsor
      redirect_to animals_path, notice: "sponsors do not have access to this" if current_user&.sponsor?
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :year_born, :weight, :bio, :species, :sponsored, :sponsor_price, :category_id, :owner_id, :profile_picture, media: [])
    end

    def check_approved
      redirect_to animals_path, notice: "Your account is not yet approved, you can't list an animal." if !current_user&.approved?
    end

    def check_ownership
      redirect_to animals_path, notice: "You are not authorized for that action." if !current_user&.admin? && Animal.find(params[:id]).owner != current_user
    end
end
