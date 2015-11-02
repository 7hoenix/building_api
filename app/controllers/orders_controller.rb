class OrdersController < ApplicationController
  respond_to :html, :json, :xml
  before_action :find_order, only: [:show, :edit, :update]

  def index
    @orders = Order.all

    respond_with @orders
  end

  def show
    respond_with @order
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      response_to do |format|
        format.html { redirect_to orders_path, notice: "The order was created" }
        format.json { render json: @order }
        format.xml { render xml: @order }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:notice] = "The order was not created."
          render :new
        end
        format.json { render json: @order }
        format.xml { render xml: @order }
      end
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      response_to do |format|
        format.html { redirect_to order_path(@order), notice: "The order was
          updated" }
        format.json { render json: @order }
        format.xml { render xml: @order }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:notice] = "The order was not updated."
          render :edit
        end
        format.json { render json: @order }
        format.xml { render xml: @order }
      end
    end

  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:amount, :user_id)
  end
end
