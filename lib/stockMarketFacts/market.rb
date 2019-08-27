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
    @market_doc = StockMarketFacts::Scraper.new.scrape_market
    # market_url = "https://money.cnn.com/data/markets/"
    # @market_doc = Nokogiri::HTML(open(market_url))
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
    @world_market << "Coming soon..."
    # world_markets = @market_doc.css("div.module-body.wsod.world-markets")
    # world_markets.css("a.world-market").each do |x|
    #   name = x.css("h3.world-market-name").text
    #   # figure out source
    # end
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
    @sector_performance << "Coming soon..."
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

  def print_market(choice)
    self.send(choice).each do |x|
      line_break
      case choice
      when "popular_stocks", "key_stats", "commodities"
        puts "Name: #{x[0].colorize( :blue )} | Currently at: #{x[1].colorize( :blue )} | Change: #{x[2].colorize( :blue )}"

      when "gainers", "losers", "ytd_stock_performance"
        puts "Name: #{x[0].colorize( :blue )} | Change: #{x[1].colorize( :blue )}"
      else
        puts x
      end
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
