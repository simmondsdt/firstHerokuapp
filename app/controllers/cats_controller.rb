class CatsController < ApplicationController
  before_action :set_cat, except: [:index, :new, :create]

  def index
    @cats = current_user.cats.paginate(page: params[:page], per_page: 15)
  end

  def show
  end

  def new
    @cat = current_user.cats.new
  end

  def create
    @cat = current_user.cats.new(cat_params)
    if @cat.save
      redirect_to cat_path(@cat), success: 'Cat created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_path(@cat), success: 'Cat updated!'
    else
      render :edit
    end
  end

  def destroy
    @cat.destroy
    redirect_to cats_path, success: 'Cat deleted!'
  end

  private
    def cat_params
      params.require(:cat).permit(:name, :age, :gender,
                                  :fur_color, :picture)
    end

    def set_cat
      @cat = current_user.cats.find(params[:id])
    end

end
