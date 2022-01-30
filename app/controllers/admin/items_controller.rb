class Admin::ItemsController < ApplicationController
    def index
        @items = Item.all
        @items = @items.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
        @item.save
        redirect_to admin_item_path(@item)
    end

    def show
    end

    def edit
    end

    def update
    end

    private

    def item_params
       params.require(:item).permit(:image,:name,:introduction,:genre_id,:price,:is_active,:image)
    end
end