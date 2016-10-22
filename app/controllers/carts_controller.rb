class CartsController < ApplicationController
  before_action :authenticate_admin!

  def show
    cart_ids = $redis.smembers current_admin_cart
    @cart_items = Item.find(cart_ids)
  end

  def add
    $redis.sadd current_admin_cart, params[:item_id]
    render json: current_admin.cart_count, status: 200
  end

  def remove
    $redis.srem current_admin_cart, params[:item_id]
    render json: current_admin.cart_count, status: 200
  end

  private

  def current_admin_cart
    "cart#{current_admin.id}"
  end
end
