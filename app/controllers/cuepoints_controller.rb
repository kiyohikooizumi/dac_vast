class CuepointsController < ApplicationController
  
  def index
    @cuepoints = Cuepoint.all
  end

  def new
    @cuepoint = Cuepoint.new
  end

  def create
    @cuepoint = Cuepoint.new(cuepoint_params)
    
    if @cuepoint.save
      flash[:success] = 'Cuepoint が正常に登録されました'
      redirect_to cuepoints_url
    else
      flash.now[:danger] = 'Cuepoint が登録されませんでした'
      render :new
    end
  end

  def edit
    @cuepoint = Cuepoint.find(params[:id])
  end

  def update
    @cuepoint = Cuepoint.find(params[:id])

    if @cuepoint.update(cuepoint_params)
      flash[:success] = 'Cuepoint は正常に更新されました'
      redirect_to cuepoints_url
    else
      flash.now[:danger] = 'Cuepoint は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @cuepoint = Cuepoint.find(params[:id])
    @cuepoint.destroy

    flash[:success] = 'Cuepoint は正常に削除されました'
    redirect_to cuepoints_url
  end

  private
    def cuepoint_params
      params.require(:cuepoint).permit(:name)
    end

end