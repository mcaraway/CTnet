class Charts::Controller < ApplicationController
  def orders
    render json: Order.shipped_by_date(params[:store_id],Date.today - 180,Date.today+1)
  end
  
  def items_by_week   
    
    render json: combine(Order.items_shipped_by_date(params[:store_id],Date.today - 180,Date.today+1)
      .map { |order|
        {name: order.sku, data: {order.week => order.quantity}}
    })
      # .inject(Hash. new(0)){|hash,key| 
        # hash[key[:name]] = key[:data];hash
      # }
    # .group_by {|x| x[:name]}
    # .inject(Hash.new(0)){|h,k| k[:name]; h[k[:name]].push(k[:data]);h}
    
    # render json: '[{"name":"FT002","data":{"2017-11-01":1392.0,"2017-12-01":1279.0}},{"name":"FT004","data":{"2017-11-01":4091.0,"2017-12-01":3279.0}}]'
  end
  
  def orders_by_week
    orders = Order.orders_by_week(params[:store_id],Date.today - 180,Date.today+1).inject(Hash.new(0)){|h,k| k.week; h[k.week] += k.quantity;h}
    items = Order.items_by_week(params[:store_id],Date.today - 180,Date.today+1).inject(Hash.new(0)){|h,k| k.week; h[k.week] += k.quantity;h}
    
    render json: [{name: '# Items', data: items},{name: '# Orders', data: orders}].chart_json
  end
  
  def parts
    render json: User.group_by_day(:created_at).count
  end
  
  def combine(data)    
    newData = {}
    
    data.each do |x|
      newData[x[:name]] = [] unless newData[x[:name]].present?
      newData[x[:name]].push x[:data]
    end
    
    combined = []
    newData.each do |index,value|
      dateData = {}
      value.each do |dateStuff|
        dateStuff.each do |dateIndex, dateValue|
          dateData[dateIndex] = dateValue
        end
      end
      values = {name: index, data: dateData}
      combined.push values
    end
    
    combined    
  end
end