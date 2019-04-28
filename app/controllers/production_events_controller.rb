class ProductionEventsController < ApplicationController
  before_action :set_production_event, only: [:show, :edit, :update, :destroy, :update_ajax]

  # GET /production_events
  # GET /production_events.json
  def index
    @production_events = ProductionEvent.all
    mos = ManufacturingOrder.default_data
    @mos = Array.new
    mos.each do |mo|
      if @production_events.detect {|f| f["content"] == mo.monum}
        p mo
      else
        @mos.push(mo)
      end
    end
  end

  # GET /production_events
  # GET /production_events.json
  def schedules
    @production_events = ProductionEvent.all
    @production_lines = ProductionLine.all
    mos = ManufacturingOrder.default_data
    @mos = Array.new
    mos.each do |mo|
      if @production_events.detect {|f| f["content"] == mo.monum}
        p mo
      else
        @mos.push(mo)
      end
    end
  end
  
  # GET /production_events/1
  # GET /production_events/1.json
  def show
  end

  def build
    mo = ManufacturingOrder.find(params[:id]) 
    p mo unless mo.nil?
    @production_event = ProductionEvent.new
    @production_event.start = params[:start].nil? ? mo.dateScheduled : params[:start]
    @production_event.end = params[:end].nil? ? mo.dateScheduled+1.day : params[:end]
    @production_event.content = mo.num
    @production_event.group = params[:group].nil? ? 1 : params[:group].to_s
    @production_event.className = "Line" + (params[:group].nil? ? 1 : params[:group].to_s)
    @production_event.moid = mo.id
    @production_event.monum = mo.num
    
    respond_to do |format|
      if @production_event.save
        format.json { render json: @production_event, status: :created, location: @production_event }
      else
        format.html { render :new }
        format.json { render json: @production_event.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /production_events/new
  def new
    @production_event = ProductionEvent.new
  end

  # GET /production_events/1/edit
  def edit
  end

  # POST /production_events
  # POST /production_events.json
  def create
    @production_event = ProductionEvent.new(production_event_params)

    respond_to do |format|
      if @production_event.save
        format.html { redirect_to @production_event, notice: 'Production event was successfully created.' }
        format.json { render :show, status: :created, location: @production_event }
      else
        format.html { render :new }
        format.json { render json: @production_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /production_events/1
  # PATCH/PUT /production_events/1.json
  def update
    respond_to do |format|
      if @production_event.update(production_event_params)
        format.html { redirect_to action: "index", notice: 'Production event was successfully updated.' }
        format.json { render :show, status: :ok, location: @production_event }
      else
        format.html { render :edit }
        format.json { render json: @production_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /production_events/update_ajax/1
  # PATCH/PUT /production_events/update_ajax/1.json
  def update_ajax

    if @production_event.update(production_event_params)
      render nothing: true, status: :ok
    else
      render nothing: true, status: fail
    end

  end
  
  # DELETE /production_events/1
  # DELETE /production_events/1.json
  def destroy
    @production_event.destroy
    respond_to do |format|
      format.html { redirect_to production_events_url, notice: 'Production event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production_event
      puts "Getting event"
      @production_event = ProductionEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_event_params
      params.require(:production_event).permit(:content, :start, :end, :group, :className, :monum, :moid)
    end
end
