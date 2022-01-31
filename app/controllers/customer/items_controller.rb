class Customer::ItemsController < ApplicationController
    def index
        @items = Item.all
        @genres = Genre.all
        @items = @items.where(genre_id: params[:genre_id].to_i) if params[:genre_id].present?
    end
    
    def show
        @genres = Genre.all
        @item = Item.find(params[:id])
        @cart_item = CartItem.new
    end
end
