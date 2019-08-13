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

  def fill_data
    market_url = "https://money.cnn.com/data/markets/"
    doc = Nokogiri::HTML(open(market_url))

    #fill popular stock data
    popular_stocks = doc.css("ul.module-body.wsod.most-popular-stocks")
    popular_stocks.css("a.stock").each do |x|
      name = x.css("span.column.stock-name").text
      price = x.css("span.column.stock-price").text
      change = x.css("span.column.stock-change").text
      @popular_stocks << [name, price, change]
    end

    #fill key stats data
    key_stats = doc.css("ul.module-body.wsod.key-stats")
    key_stats.css("a.quote").each do |x|
      name = x.css("span.column.quote-name").text
      quote = x.css("span.column.quote-col").text
      change = x.css("span.column.quote-change").text
      @key_stats << [name, quote, change]
    end

    #fill world market data
    world_markets = doc.css("div.module-body.wsod.world-markets")
    world_markets.css("a.world-market").each do |x|
      name = x.css("h3.world-market-name").text
      # figure out source
    end

    #fill gainers
    gainers = doc.css("ul.module-body.wsod.gainers")
    gainers.css("a.two-equal-columns.quote").each do |x|
      name = x.css("span.column.quote-name").text
      change = x.css("span.column.quote-change").text
      @gainers << [name, change]
    end

    #fill losers
    losers = doc.css("ul.module-body.wsod.losers")
    losers.css("a.two-equal-columns.quote").each do |x|
      name = x.css("span.column.quote-name").text
      change = x.css("span.column.quote-change").text
      @losers << [name, change]
    end

    #fill sector performance
    # sector_performance = doc.css("div.module-body")
    # sector_performance.css("")

    #fill commodities
    commodities = doc.css("ul.module-body.wsod.commodities")
    commodities.css("a.quote").each do |x|
      name = x.css("span.column.quote-name").text
      price = x.css("span.column.quote-dollar").text
      change = x.css("span.column.quote-change").text
      @commodities << [name, price, change]
    end

    #fill ytd stock performance
    ytd_stock_performance = doc.css("ul.module-body.wsod.how-stocks-doing")
    ytd_stock_performance.css("a.quote").each do |x|
      name = x.css("span.column.quote-name").text
      if x.css("span.column.quote-change.posData").text != ""
        change = x.css("span.column.quote-change.posData").text
      elsif x.css("span.column.quote-change.negData").text != ""
        change = x.css("span.column.quote-change.negData").text
      end
      @ytd_stock_performance << [name, change]
    end


  end
  ##### PRINT METHODS

  def print_popular_stocks
    @popular_stocks.each do |stock|
      puts "#{stock[0]} | Current Price: #{stock[1]} | Change: #{stock[2]}"
    end
  end

  def print_key_stats
    @key_stats.each do |stat|
      puts "#{stat[0]} | Current Quote: #{stat[1]} | Change: #{stat[2]}"
    end
  end

  def print_gainers
    @gainers.each do |stock|
      puts "#{stock[0]} | Change: #{stock[1]}"
    end
  end

  def print_losers
    @losers.each do |stock|
      puts "#{stock[0]} | Change: #{stock[1]}"
    end
  end

  def print_commodities
    @commodities.each do |item|
      puts "#{item[0]} | Current Price: #{item[1]} | Change: #{item[2]}"
    end
  end

  def print_ytd_stock_performance
    @ytd_stock_performance.each do |stock|
      puts "#{stock[0]} | Change: #{stock[1]}"
    end
  end

end




=begin
git add --all
git commit -m "modified: market.rb"
git push

=end
