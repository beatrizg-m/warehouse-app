class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possivel registrar o pedido.'
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, notice: 'Você não possui acesso a este pedido'
    end
  end

  def edit

  end

  def index
    @orders = current_user.orders
  end

  def search
    @code = params['query']
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end
end
