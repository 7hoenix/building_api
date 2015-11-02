class ItemsController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @items = Item.all

    respond_with @items
  end

  def show
    @item = Item.find_by(id: params[:id])

    respond_with @item
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      response_to do |format|
        format.html { redirect_to items_path, notice: "The item was created." }
      end
    else
      respond_to do |format|
        format.html do |format|
          flash.now[:notice] = "The item was not created."
          render :edit
        end
      end
    end
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(item_params)
      redirect_to item_path(@item), notice: "The item was updated."
    else
      flash.now[:notice] = "The item was not updated."
      render :edit
    end
  end

  def destroy
    Item.destroy(params[:id])

    redirect_to items_path, notice: "The item was deleted."
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end
end
