class StockMarketFacts::Scraper
  attr_accessor :market_html_doc

  def initialize
    @market_html_doc = ""
  end

  def scrape
    market_url = "https://money.cnn.com/data/markets/"
    @market_html_doc = Nokogiri::HTML(open(market_url))
  end


end
