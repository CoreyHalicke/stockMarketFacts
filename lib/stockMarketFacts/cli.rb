class StockMarketFacts::CLI

  def call
    puts "Welcome to Quick Stock Market Facts!"
    main_menu
  end

  def main_menu
  input = nil
    while input != 'x'
      puts <<-DOC
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
        'x' to exit
      DOC
      input = gets.strip.downcase
      case input
      when "1"
        puts "Most Popular Stocks"
      when "2"
        puts "Key Stats"
      when "3"
        puts "World Markets"
      when "4"
        puts "Gainers"
      when "5"
        puts "Losers"
      when "6"
        puts "Sector Performance"
      when "7"
        puts "Commodities"
      when "8"
        puts "How stocks are doing this year"

      when "9"
        puts "Search by Stock Symbol"

        puts "Type in the Stock Symbol for the Company you are looking for:"
      end
    end
  end

end
