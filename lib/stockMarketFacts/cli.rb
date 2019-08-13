class StockMarketFacts::CLI

  def call
    puts "Welcome to Quick Stock Market Facts!"

    main_menu
    # goodbye
  end

  def list_menu
    puts <<-DOC

    ::: MAIN MENU :::

    What would you like to view about the market?
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

  def options
    puts ""
    puts "Enter a number (1-9) from the main menu | 'm' to view menu again | 'x' to exit"
  end

  def main_menu
  @input = nil
  list_menu
  market = StockMarketFacts::Market.new

    while @input != 'x'
      @input = gets.strip.downcase
      case @input
      when "m"
        list_menu
      when "1"
        puts ""
        puts "::: Most Popular Stocks :::"
        market.print_popular_stocks
        options
      when "2"
        puts ""
        puts "::: Key Stats :::"
        market.print_key_stats
        options
      when "3"
        puts ""
        puts "::: World Markets :::"
        puts "Coming Soon..."
        options
      when "4"
        puts ""
        puts "::: Gainers :::"
        market.print_gainers
        options
      when "5"
        puts ""
        puts "::: Losers :::"
        market.print_losers
        options
      when "6"
        puts ""
        puts "::: Sector Performance :::"
        puts "Coming Soon..."
        options
      when "7"
        puts ""
        puts "::: Commodities :::"
        market.print_commodities
        options
      when "8"
        puts ""
        puts "::: How stocks are doing this year :::"
        market.print_ytd_stock_performance
        options
      when "9"
        puts ""
        puts "::: Search by Stock Symbol :::"
        puts "Type in the Stock Symbol for the Company you are looking for:"
        search_stock_menu
      when "x"

      else
        puts ""
        puts "Not sure what you want, please pick an option from the menu."
        list_menu
      end
    end
  end


  def goodbye
    puts "Thank you for using Quick Stock Market Facts!"
    puts "See you soon!"
  end

  def list_stock_search_menu
    puts <<-DOC

    ::: #{@company_symbol} STOCK MENU :::

    What would you like to know about #{@company_symbol}?
      1. Current Price / Today's Change / 52-Week Range / Year-to-Date Change
      2. Today's Trading Information
      3. Growth & Valuation
      4. Competitors
      5. Financials
      6. Profile
      7. Company Description
      8. Company Contact Information
      9. Shareholders
      10. Top Executives

    DOC

  end

  def search_stock_options
    puts ""
    puts "Enter a number (1-10) from the company stock menu | 'm' to view main menu | 'b' to go to company stock menu | 'x' to exit"
  end

  def search_stock_menu
    @input = nil
    @company_symbol = gets.strip.upcase

    list_stock_search_menu
    while @input != 'x'
      @input = gets.strip.downcase
      case @input
      when "m"
        main_menu
      when "b"
        list_stock_search_menu
      when "1"
        puts "Current Price / Today's Change / 52-Week Range / Year-to-Date Change"
        search_stock_options
      when "2"
        puts "Today's Trading Information"
        search_stock_options
      when "3"
        puts "Growth & Valuation"
        search_stock_options
      when "4"
        puts "Competitors"
        search_stock_options
      when "5"
        puts "Financials"
        search_stock_options
      when "6"
        puts "Profile"
        search_stock_options
      when "7"
        puts "Company Description"
        search_stock_options
      when "8"
        puts "Company Contact Information"
        search_stock_options
      when "9"
        puts "Shareholders"
        search_stock_options
      when "10"
        puts "Top Executives"
        search_stock_options
      when "x"

      else
        puts "Not sure what you want, please pick an option from the menu."
        list_stock_search_menu
      end
    end
  end

end


=begin
git add --all
git commit -m "modified: cli.rb"
git push

=end
