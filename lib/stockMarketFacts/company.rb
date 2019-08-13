class StockMarketFacts::Market

  attr_accessor :popular_stocks, :key_stats, :world_market, :gainers, :losers, :sector_performance, :commodities, :ytd_stock_performance

  def initialize
    @popular_stocks = []
    @key_stats = []
    @world_market = []
    @gainers = []
    @losers = []
    @sector_performance = []
    @commodities = []
    @ytd_stock_performance = []
    self.fill_data
  end



end




=begin
git add --all
git commit -m "modified: company.rb"
git push

=end
