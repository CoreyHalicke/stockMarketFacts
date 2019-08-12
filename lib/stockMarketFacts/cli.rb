

class StockMarketFacts::CLI

  def call
    puts <<-DOC
    Welcome to Stock Market Facts!
      What would you like to view?
        1. Most Popular Stocks
        2. Key Stats
        3. World Markets
        4. Gainers
        5. Losers
        6. Sector Performance
        7. Commodities
        8. How stocks are doing this year
        9. Search by Stock Symbol
      DOC

  end

end
