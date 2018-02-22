class RestconnectionsController < ApplicationController
  before_action :set_restconnection, only: [:show, :edit, :update, :destroy]

  # GET /restconnections
  # GET /restconnections.json
  def index
    @restconnections = Restconnection.all
  end

  # GET /restconnections/1
  # GET /restconnections/1.json
  def show
  end

  # GET /restconnections/new
  def new
    @restconnection = Restconnection.new
  end

  # GET /restconnections/1/edit
  def edit
  end

  # POST /restconnections
  # POST /restconnections.json
  def create
    @restconnection = Restconnection.new(restconnection_params)

    respond_to do |format|
      if @restconnection.save
        format.html { redirect_to @restconnection, notice: 'Restconnection was successfully created.' }
        format.json { render :show, status: :created, location: @restconnection }
      else
        format.html { render :new }
        format.json { render json: @restconnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restconnections/1
  # PATCH/PUT /restconnections/1.json
  def update
    respond_to do |format|
      if @restconnection.update(restconnection_params)
        format.html { redirect_to @restconnection, notice: 'Restconnection was successfully updated.' }
        format.json { render :show, status: :ok, location: @restconnection }
      else
        format.html { render :edit }
        format.json { render json: @restconnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restconnections/1
  # DELETE /restconnections/1.json
  def destroy
    @restconnection.destroy
    respond_to do |format|
      format.html { redirect_to restconnections_url, notice: 'Restconnection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restconnection
      @restconnection = Restconnection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restconnection_params
      params.require(:restconnection).permit(:host, :appname, :appid, :description, :debug, :username, :password)
    end
end
