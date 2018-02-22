class DbconnectionsController < ApplicationController
  before_action :set_dbconnection, only: [:show, :edit, :update, :destroy]

  # GET /dbconnections
  # GET /dbconnections.json
  def index
    @dbconnections = Dbconnection.all
  end

  # GET /dbconnections/1
  # GET /dbconnections/1.json
  def show
  end

  # GET /dbconnections/new
  def new
    @dbconnection = Dbconnection.new
  end

  # GET /dbconnections/1/edit
  def edit
  end

  # POST /dbconnections
  # POST /dbconnections.json
  def create
    @dbconnection = Dbconnection.new(dbconnection_params)

    respond_to do |format|
      if @dbconnection.save
        format.html { redirect_to @dbconnection, notice: 'Dbconnection was successfully created.' }
        format.json { render :show, status: :created, location: @dbconnection }
      else
        format.html { render :new }
        format.json { render json: @dbconnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dbconnections/1
  # PATCH/PUT /dbconnections/1.json
  def update
    respond_to do |format|
      if @dbconnection.update(dbconnection_params)
        format.html { redirect_to @dbconnection, notice: 'Dbconnection was successfully updated.' }
        format.json { render :show, status: :ok, location: @dbconnection }
      else
        format.html { render :edit }
        format.json { render json: @dbconnection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dbconnections/1
  # DELETE /dbconnections/1.json
  def destroy
    @dbconnection.destroy
    respond_to do |format|
      format.html { redirect_to dbconnections_url, notice: 'Dbconnection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dbconnection
      @dbconnection = Dbconnection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dbconnection_params
      params.require(:dbconnection).permit(:adapter, :mode, :host, :port, :username, :password, :database, :encoding)
    end
end
