class StockMarketFacts::CLI

  def call
    puts "Welcome to Quick Stock Market Facts!"
    main_menu
    goodbye
  end

  def list_menu
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
    DOC
  end

  def main_menu
  input = nil
  list_menu
    while input != 'x'
      input = gets.strip.downcase
      case input
      when "m"
        list_menu
      when "1"
        puts "Most Popular Stocks"
        options
      when "2"
        puts "Key Stats"
        options
      when "3"
        puts "World Markets"
        options
      when "4"
        puts "Gainers"
        options
      when "5"
        puts "Losers"
        options
      when "6"
        puts "Sector Performance"
        options
      when "7"
        puts "Commodities"
        options
      when "8"
        puts "How stocks are doing this year"
        options
      when "9"
        puts "Search by Stock Symbol"
        puts "Type in the Stock Symbol for the Company you are looking for:"
        search_stock_menu
      when "x"

      end
    end
  end

  def options
    puts "Enter a number (1-9) from the main menu | 'm' to view menu again | 'x' to exit"
  end

  def goodbye
    puts "Thank you for using Quick Stock Market Facts!"
    puts "See you soon!"
  end

  def list_stock_search_menu
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
    DOC

  end

  def search_stock_menu
    input = nil
    list_menu
      while input != 'x'
        input = gets.strip.downcase
        case input
        when "m"
          list_menu
        when "1"
          puts "Most Popular Stocks"
          options
        when "2"
          puts "Key Stats"
          options
        when "3"
          puts "World Markets"
          options
        when "4"
          puts "Gainers"
          options
        when "5"
          puts "Losers"
          options
        when "6"
          puts "Sector Performance"
          options
        when "7"
          puts "Commodities"
          options
        when "8"
          puts "How stocks are doing this year"
          options
        when "9"
          puts "Search by Stock Symbol"
          puts "Type in the Stock Symbol for the Company you are looking for:"
        when "x"

        end

    main_menu
  end
end

=begin
git add --all
git commit -m "modified: cli.rb"
git push

=end
