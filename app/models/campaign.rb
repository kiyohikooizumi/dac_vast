class Campaign < ApplicationRecord
  validates :name, length: { in: 5..20 }, uniqueness: true
  validates_datetime :end_at, :after => :start_at 
  validates :limit_start, length: { in: 0..10000 }, numericality: { only_integer: true }
  validates :movie_url, length: { in: 5..100 }
  has_and_belongs_to_many :cuepoints

  # 有効なキャンペーン一覧を返す
  #  - 対象のCue Pointと紐付いている。
  #  - キャンペーンが開始していて、終了する前。
  #  - Resultのスタート数(count_start)がキャンペーンの制限(limit_start)以内。
  # @param [Cuepoint, #read] cuepoint キャンペーンの対象となっている Cue Point
  # @return [Array] 該当キャンペーンの配列
  
  def self.current_available(cuepoint)
    campaigns = cuepoint.campaigns.
      where("start_at <= '#{Time.now}' AND end_at >= '#{Time.now}'").to_a
    campaigns.delete_if do |campaign|
      result = Result.where(campaign: campaign, cuepoint: @cuepoint).first
      !result.blank? && result.count_start >= campaign.limit_start
    end
    
  end
end
