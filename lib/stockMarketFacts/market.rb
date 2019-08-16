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
    self.pull_data
  end

  ## do i want to store past data in @@all?

  ##### DATA PULL #####

  # pull market data and store it
  def pull_data
    market_url = "https://money.cnn.com/data/markets/"
    @market_doc = Nokogiri::HTML(open(market_url))

    grab_popular_stock
    grab_key_stats
    grab_world_market
    grab_gainers
    grab_losers
    grab_sector_performance
    grab_commodities
    grab_ytd_stock_performance
  end

  ##### GRAB DATA #####

  #fill popular stock data
  def grab_popular_stock
    popular_stocks = @market_doc.css("ul.module-body.wsod.most-popular-stocks")
    popular_stocks.css("a.stock").each do |x|
      name = x.css("span.column.stock-name").text
      price = x.css("span.column.stock-price").text
      change = x.css("span.column.stock-change").text
      @popular_stocks << [name, price, change]
    end
  end

  #fill key stats data
  def grab_key_stats
    key_stats = @market_doc.css("ul.module-body.wsod.key-stats")
    key_stats.css("a.quote").each do |x|
      name = x.css("span.column.quote-name").text
      quote = x.css("span.column.quote-col").text
      change = x.css("span.column.quote-change").text
      @key_stats << [name, quote, change]
    end
  end

  #fill world market data
  def grab_world_market
    world_markets = @market_doc.css("div.module-body.wsod.world-markets")
    world_markets.css("a.world-market").each do |x|
      name = x.css("h3.world-market-name").text
      # figure out source
    end
  end

  #fill gainers
  def grab_gainers
    gainers = @market_doc.css("ul.module-body.wsod.gainers")
    gainers.css("a.two-equal-columns.quote").each do |x|
      name = x.css("span.column.quote-name").text
      change = x.css("span.column.quote-change").text
      @gainers << [name, change]
    end
  end

  #fill losers
  def grab_losers
    losers = @market_doc.css("ul.module-body.wsod.losers")
    losers.css("a.two-equal-columns.quote").each do |x|
      name = x.css("span.column.quote-name").text
      change = x.css("span.column.quote-change").text
      @losers << [name, change]
    end
  end

  #fill sector performance
  def grab_sector_performance
    # sector_performance = @market_doc.css("div.module-body")
    # sector_performance.css("")
  end

  #fill commodities
  def grab_commodities
    commodities = @market_doc.css("ul.module-body.wsod.commodities")
    commodities.css("a.quote").each do |x|
      name = x.css("span.column.quote-name").text
      price = x.css("span.column.quote-dollar").text
      change = x.css("span.column.quote-change").text
      @commodities << [name, price, change]
    end
  end

  #fill ytd stock performance
  def grab_ytd_stock_performance
    ytd_stock_performance = @market_doc.css("ul.module-body.wsod.how-stocks-doing")
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


  ##### PRINT METHODS #####

  def print_popular_stocks
    @popular_stocks.each do |stock|
      line_break
      puts "Name: #{stock[0].colorize( :blue )} | Current Price: #{stock[1].colorize( :blue )} | Change: #{stock[2].colorize( :blue )}"
    end
    line_break
  end

  def print_key_stats
    @key_stats.each do |stat|
      line_break
      puts "Name: #{stat[0].colorize( :blue )} | Current Quote: #{stat[1].colorize( :blue )} | Change: #{stat[2].colorize( :blue )}"
    end
    line_break
  end

  def print_gainers
    @gainers.each do |stock|
      line_break
      puts "Name: #{stock[0].colorize( :blue )} | Change: #{stock[1].colorize( :blue )}"
    end
    line_break
  end

  def print_losers
    @losers.each do |stock|
      line_break
      puts "Name: #{stock[0].colorize( :blue )} | Change: #{stock[1].colorize( :blue )}"
    end
    line_break
  end

  def print_commodities
    @commodities.each do |item|
      line_break
      puts "Name: #{item[0].colorize( :blue )} | Current Price: #{item[1].colorize( :blue )} | Change: #{item[2].colorize( :blue )}"
    end
    line_break
  end

  def print_ytd_stock_performance
    @ytd_stock_performance.each do |stock|
      line_break
      puts "Name: #{stock[0].colorize( :blue )} | Change: #{stock[1].colorize( :blue )}"
    end
    line_break
  end


  ##### COSMETIC METHODS #####

  def line_break
    puts "________________________________________________________________________________"
  end

  def clear_data
    @popular_stocks = []
    @key_stats = []
    @world_market = []
    @gainers = []
    @losers = []
    @sector_performance = []
    @commodities = []
    @ytd_stock_performance = []
  end

end




=begin
git add --all
git commit -m "modified: market.rb"
git push

=end
