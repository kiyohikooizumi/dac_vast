class CampaignsController < ApplicationController

  def index
    unless params[:cuepoint_id]
      @campaigns = Campaign.all
    else
      @cuepoint = Cuepoint.find(params[:cuepoint_id])
      @campaigns = Campaign.current_available(@cuepoint)
      
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type'
    end
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    
    if @campaign.save
      flash[:success] = 'Campaign が正常に登録されました'
      redirect_to campaigns_url
    else
      flash.now[:danger] = 'Campaign が登録されませんでした'
      render :new
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    
    if @campaign.update(campaign_params)
      flash[:success] = 'Campaign は正常に更新されました'
      redirect_to campaigns_url
    else
      flash.now[:danger] = 'Campaign は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    flash[:success] = 'Campaign は正常に削除されました'
    redirect_to campaigns_url
  end

  private
    def campaign_params
      params.require(:campaign).permit(:name, :start_at, :end_at, :limit_start, :movie_url, :cuepoint_ids => [])
    end
end
