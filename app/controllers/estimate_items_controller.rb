class EstimateItemsController < ApplicationController
  before_action :set_estimate_item, only: [:show, :edit, :update, :destroy]
  before_action :get_children, only: [:create, :update ]

  # GET /estimate_items
  # GET /estimate_items.json
  def index
    @estimate_items = EstimateItem.all
    
    respond_to do |format|
      format.html { @estimate_items }
      format.json do
        @estimate_items = EstimateItem.search(params[:term])
         render json: @estimate_items.map(&:name)
       end
     end
  end

  # GET /estimate_items/1
  # GET /estimate_items/1.json
  def show
  end

  # GET /estimate_items/new
  def new
    @estimate_item = EstimateItem.new
    @option_groups = OptionGroup.all
    
    if params[:type] == "composite"
      render :action => 'new_composite'
    end
  end

  # GET /estimate_items/1/edit
  def edit
    @option_groups = OptionGroup.all
  end

  # POST /estimate_items
  # POST /estimate_items.json
  def create
    @estimate_item = EstimateItem.new(estimate_item_params)

    respond_to do |format|
      if @estimate_item.save
        format.html { redirect_to @estimate_item, notice: 'Estimate item was successfully created.' }
        format.json { render :show, status: :created, location: @estimate_item }
      else
        format.html { render :new }
        format.json { render json: @estimate_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estimate_items/1
  # PATCH/PUT /estimate_items/1.json
  def update
    @estimate_item.part_id = @part.try(:id)
    @estimate_item.option_group_id = @option_group.try(:id)
    
    respond_to do |format|
      if @estimate_item.update(estimate_item_params)
        format.html { redirect_to @estimate_item, notice: 'Estimate item was successfully updated.' }
        format.json { render :show, status: :ok, location: @estimate_item }
      else
        format.html { render :edit }
        format.json { render json: @estimate_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimate_items/1
  # DELETE /estimate_items/1.json
  def destroy
    @estimate_item.destroy
    respond_to do |format|
      format.html { redirect_to estimate_items_url, notice: 'Estimate item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_children
      @part = Part.search(params[:part_name])
      @option_group = OptionGroup.search(params[:option_group_name])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate_item
      @estimate_item = EstimateItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estimate_item_params
      params.require(:estimate_item).permit(:name, :part_id, :part_name, :amount, :option_group_id, :option_group_name)
    end
end
