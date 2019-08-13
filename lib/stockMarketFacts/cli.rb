class StockMarketFacts::CLI

  def call
    puts "Welcome to Quick Stock Market Facts!".blue

    main_menu
    goodbye
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
    puts "Enter a number (1-9) from the main menu | 'm' to view menu again | 'x' to exit".red
  end

  def main_menu
  @input = nil
  list_menu
  market = StockMarketFacts::Market.new

    while @input != 'x'
      @input = gets.strip.downcase
      case @input
      when "m"
        main_menu
      when "1"
        puts ""
        puts "::: Most Popular Stocks :::".blue
        market.print_popular_stocks
        options
      when "2"
        puts ""
        puts "::: Key Stats :::".blue
        market.print_key_stats
        options
      when "3"
        puts ""
        puts "::: World Markets :::".blue
        puts "Coming Soon..."
        options
      when "4"
        puts ""
        puts "::: Gainers :::".blue
        market.print_gainers
        options
      when "5"
        puts ""
        puts "::: Losers :::".blue
        market.print_losers
        options
      when "6"
        puts ""
        puts "::: Sector Performance :::".blue
        puts "Coming Soon..."
        options
      when "7"
        puts ""
        puts "::: Commodities :::".blue
        market.print_commodities
        options
      when "8"
        puts ""
        puts "::: How stocks are doing this year :::".blue
        market.print_ytd_stock_performance
        options
      when "9"
        puts ""
        puts "::: Search by Stock Symbol :::".blue
        puts "Type in the Stock Symbol for the Company you are looking for:"
        search_stock_menu
      when "x"

      else
        puts ""
        puts "Not sure what you want, please pick an option from the menu.".red
        list_menu
      end
    end
  end


  def goodbye
    puts ""
    puts "Thank you for using Quick Stock Market Facts!".blue
    puts "See you soon!".blue
  end

  def list_stock_search_menu
    puts <<-DOC

    ::: #{@company_symbol} STOCK MENU :::

    What would you like to know about #{@company_symbol}?
      1. Current Price / Today's Change / Year-to-Date Change
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
    puts "Enter a number (1-10) from the company stock menu | 'm' to view main menu | 'b' to go to company stock menu | 'x' to exit".red
  end

  def search_stock_menu
    @input = nil
    @company_symbol = gets.strip.upcase
    company = StockMarketFacts::Company.new(@company_symbol)
    list_stock_search_menu
    while @input != 'x'
      @input = gets.strip.downcase
      case @input
      when "m"
        main_menu
      when "b"
        list_stock_search_menu
      when "1"
        ### quote url
        puts "::: #{@company_symbol}: Quick Facts :::".blue
        company.print_simple_performance(@company_symbol)
        search_stock_options
      when "2"
        ### quote url
        puts ""
        puts "::: #{@company_symbol}: Today's Trading Information :::".blue
        company.print_today_trading(@company_symbol)
        search_stock_options
      when "3"
        ### quote url
        puts ""
        puts "::: #{@company_symbol}: Growth & Valuation :::".blue
        company.print_growth(@company_symbol)
        search_stock_options
      when "4"
        ### quote url
        puts ""
        puts "::: #{@company_symbol}: Competitors :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "5"
        ### quote url
        puts ""
        puts "::: #{@company_symbol}: Financials :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "6"
        ### quote url
        puts ""
        puts "::: #{@company_symbol}: Profile :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "7"
        ### profile url
        puts ""
        puts "::: #{@company_symbol}: Company Description :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "8"
        ### profile url
        puts ""
        puts "::: #{@company_symbol}: Company Contact Information :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "9"
        ### profile url
        puts ""
        puts "::: #{@company_symbol}: Shareholders :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "10"
        ### profile url
        puts ""
        puts "::: #{@company_symbol}: Top Executives :::".blue
        puts "Coming Soon..."
        search_stock_options
      when "x"

      else
        puts ""
        puts "Not sure what you want, please pick an option from the menu.".red
        list_stock_search_menu
        search_stock_options
      end
    end
  end

end


=begin
git add --all
git commit -m "modified: cli.rb"
git push

=end
