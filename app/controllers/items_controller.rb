class ItemsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  def index
		@items = Item.all #select * by category
	end

	def show
		@item = Item.find(params[:id])
    @cart_action = @item.cart_action current_admin.try :id
  end

	def new
		@item = current_admin.items.build
	end

	def create
		@item = current_admin.items.build(item_params)
		if @item.save
			flash[:success] = "Your item was created successfully! "
			redirect_to items_path
		else
			render :new
		end
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		if @item.update(item_params)
			flash[:success] = "Your item was updated successfully!"
			redirect_to item_path(@item)
		else
			render :edit
		end
	end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:success] ='Item was successfully destroyed!'
      redirect_to item_path
    end
  end

  # def cart_action(current_admin_id)
  #   if $redis.sismember "cart#{current_admin_id}", id
  #     "Remove from"
  #   else
  #     "Add to"
  #   end
  # end

	private

		def item_params
			params.require(:item).permit(:name, :price, :num, :image, :description)
		end
end
