class ProductionLinesController < ApplicationController
  before_action :set_production_line, only: [:show, :edit, :update, :destroy]

  def data
    dataText = [
                {
                    :start => Date.new(2019,4,8),
                    :end => Date.new(2019,4,12),
                    :content => 'Order 1',
                    :group => 'Line 1',
                    :className => 'Line1',
                },
                {
                    'start' => Date.new(2019,4,13),
                    'end' => Date.new(2019,4,15),
                    'content' => 'Order 2',
                    'group' => 'Line 1',
                    'className' => 'Line1'
                },
                {
                    'start' => Date.new(2019,4,8),
                    'end' => Date.new(2019,4,12),
                    'content' => 'Order 3',
                    'group' => 'Line 2',
                    'className' => 'Line2'
                },

            ]
    respond_to do |format|
      format.json {render json: dataText, layout: false} # Add this line to you respond_to block
    end
  end
  
  # GET /production_lines
  # GET /production_lines.json
  def index
    @production_lines = ProductionLine.all
  end

  # GET /production_lines/1
  # GET /production_lines/1.json
  def show
  end

  # GET /production_lines/new
  def new
    @production_line = ProductionLine.new
  end

  # GET /production_lines/1/edit
  def edit
  end

  # POST /production_lines
  # POST /production_lines.json
  def create
    @production_line = ProductionLine.new(production_line_params)

    respond_to do |format|
      if @production_line.save
        format.html { redirect_to @production_line, notice: 'Production line was successfully created.' }
        format.json { render :show, status: :created, location: @production_line }
      else
        format.html { render :new }
        format.json { render json: @production_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /production_lines/1
  # PATCH/PUT /production_lines/1.json
  def update
    respond_to do |format|
      if @production_line.update(production_line_params)
        format.html { redirect_to @production_line, notice: 'Production line was successfully updated.' }
        format.json { render :show, status: :ok, location: @production_line }
      else
        format.html { render :edit }
        format.json { render json: @production_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /production_lines/1
  # DELETE /production_lines/1.json
  def destroy
    @production_line.destroy
    respond_to do |format|
      format.html { redirect_to production_lines_url, notice: 'Production line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_line
      @production_line = ProductionLine.find(params[:id])   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_line_params
      params.require(:production_line).permit(:name, :tqx)
    end
end
