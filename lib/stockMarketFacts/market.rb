class StockMarketFacts::Market

  attr_accessor :popular_stocks, :key_stats, :world_market, :gainers, :losers, :sector_performance, :commodities, :ytd_stock_performance

  # @popular_stocks = []
  # @key_stats = []


  def self.market_scrape
    market_scrape = self.new
    market_scrape.popular_stocks = []
    market_scrape.key_stats = []
    market_scrape.world_market = []
    market_scrape.gainers = []
    market_scrape.losers = []
    market_scrape.sector_performance = []
    market_scrape.commodities = []
    market_scrape.ytd_stock_performance = []
  end

  def self.popular_stocks
    @popular_stocks << ['Apple', '200.48', '-0.25%']
    @popular_stocks << ['Citigroup', '64.25', '-2.73%']
    @popular_stocks << ['General El', '64.25', '-2.73%']
    @popular_stocks.each do |stock|
      puts "#{stock[0]} | Current Price: #{stock[1]} | Change: #{stock[2]}"
    end
  end

  def self.key_stats
    @key_stats << ['10-Year Yeild', '1.64%', '-5.48%']
    @key_stats << ['Oil', '$54.78', '-0.27%']
    @key_stats << ['Yen', '¥105.29', '-0.09']
    @key_stats << ['Euro', '$1.12', '+0.02%']
    @key_stats << ['Gold', '$1,524,40', '+0.47%']
    @key_stats.each do |stat|
      puts "#{stat[0]} | Current Price: #{stat[1]} | Change: #{stat[2]}"
    end
  end

  def self.reset_data

  end


end
