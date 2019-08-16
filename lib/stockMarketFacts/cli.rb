class StockMarketFacts::CLI

  def call
    puts_blanks
    puts "Welcome to Quick Stock Market Facts!".colorize( :blue )

    main_menu
    goodbye
  end

  def list_menu
    puts <<-DOC

    ::: MAIN MENU :::

    What would you like to view about the market?
      [1] Most Popular Stocks
      [2] Key Stats
      [3] World Markets *Coming Soon*
      [4] Gainers
      [5] Losers
      [6] Sector Performance *Coming Soon*
      [7] Commodities
      [8] How stocks are doing this year
      [a] to run all
      [s] Search by Stock Symbol
      [x] Exit Program

    DOC

  end

  def options
    blank
    puts "[1-8] from the main menu options".colorize( :gray )
    puts "[a] to run all"
    puts "[s] to search by Stock Symbol"
    puts "[m] to view menu again".colorize( :gray )
    puts "[x] to exit".colorize( :gray )
  end

  def main_menu
  @input = nil
  list_menu
  @market = StockMarketFacts::Market.new

    while @input != 'x'
      @input = gets.strip.downcase
      case @input
      when "m"
        main_menu
      when "1"
        puts_blanks
        puts "::: Most Popular Stocks :::".colorize( :blue )
        blank
        @market.print_popular_stocks
        options
      when "2"
        puts_blanks
        puts "::: Key Stats :::".colorize( :blue )
        blank
        @market.print_key_stats
        options
      when "3"
        puts_blanks
        puts "::: World Markets :::".colorize( :blue )
        blank
        puts "Coming Soon..."
        options
      when "4"
        puts_blanks
        puts "::: Gainers :::".colorize( :blue )
        blank
        @market.print_gainers
        options
      when "5"
        puts_blanks
        puts "::: Losers :::".colorize( :blue )
        blank
        @market.print_losers
        options
      when "6"
        puts_blanks
        puts "::: Sector Performance :::".colorize( :blue )
        blank
        puts "Coming Soon..."
        options
      when "7"
        puts_blanks
        puts "::: Commodities :::".colorize( :blue )
        blank
        @market.print_commodities
        options
      when "8"
        puts_blanks
        puts "::: How stocks are doing this year :::".colorize( :blue )
        blank
        @market.print_ytd_stock_performance
        options
      when "s"
        puts_blanks
        puts "::: Search by Stock Symbol :::".colorize( :blue )
        blank
        puts "Type in the Stock Symbol for the Company you are looking for:"
        search_stock_menu
      when "x"

      when "a"
        puts_blanks
        puts "::: Most Popular Stocks :::".colorize( :blue )
        blank
        @market.print_popular_stocks

        puts_blanks
        puts "::: Key Stats :::".colorize( :blue )
        blank
        @market.print_key_stats

        puts_blanks
        puts "::: World Markets :::".colorize( :blue )
        blank
        puts "Coming Soon..."

        puts_blanks
        puts "::: Gainers :::".colorize( :blue )
        blank
        @market.print_gainers

        puts_blanks
        puts "::: Losers :::".colorize( :blue )
        blank
        @market.print_losers

        puts_blanks
        puts "::: Sector Performance :::".colorize( :blue )
        blank
        puts "Coming Soon..."

        puts_blanks
        puts "::: Commodities :::".colorize( :blue )
        blank
        @market.print_commodities

        puts_blanks
        puts "::: How stocks are doing this year :::".colorize( :blue )
        blank
        @market.print_ytd_stock_performance
        options

      else
        puts_blanks
        puts "Not sure what you want, please pick an option from the menu.".colorize( :red )
        list_menu
      end
    end
  end

  #goodbye message when leaving app
  def goodbye
    puts_blanks
    puts "Thank you for using Quick Stock Market Facts!".colorize( :blue )
    puts "See you soon!".colorize( :blue )
    blank
    # @market.clear_data
  end

  #second level cli menu
  def list_stock_search_menu
    puts <<-DOC

    ::: #{@company_name} STOCK MENU :::

    What would you like to know about #{@company_name}?
      [1] Current Price / Today's Change / Year-to-Date Change
      [2] Today's Trading Information
      [3] Growth & Valuation
      [4] Competitors
      [5] Financials
      [6] Profile
      [7] Company Description
      [8] Company Contact Information
      [9] Shareholders
      [10] Top Executives *Coming Soon*
      [a] to run all
      [x] Exit Program


    DOC

  end

  #print simple instructions in second level cli
  def search_stock_options
    blank
    puts "[1-10] from the company menu options".colorize( :gray )
    puts "[a] to run all"
    puts "[m] to view menu again".colorize( :gray )
    puts "[b] to view company menu again".colorize( :gray )
    puts "[x] to exit".colorize( :gray )
  end

  #second level cli
  def search_stock_menu
    @input = nil
    @company_symbol = gets.strip.upcase
    company = StockMarketFacts::Company.new(@company_symbol)
    #needs to validate stock symbol input
    quote_doc = company.pull_quote_data(@company_symbol)

    until quote_doc.css("h1").text != "Symbol not found"
      puts "Please enter a valid Stock Symbol.".colorize( :red )
      @company_symbol = gets.strip.upcase
      quote_doc = company.pull_quote_data(@company_symbol)
    end

    @company_name = quote_doc.css("h1").text

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
        puts_blanks
        puts "::: #{@company_name} - Quick Facts :::".colorize( :blue )
        blank
        company.print_simple_performance(@company_symbol)
        search_stock_options
      when "2"
        ### quote url
        puts_blanks
        puts "::: #{@company_name} - Today's Trading Information :::".colorize( :blue )
        blank
        company.print_today_trading(@company_symbol)
        search_stock_options
      when "3"
        ### quote url
        puts_blanks
        puts "::: #{@company_name} - Growth & Valuation :::".colorize( :blue )
        blank
        company.print_growth(@company_symbol)
        search_stock_options
      when "4"
        ### quote url
        puts_blanks
        puts "::: #{@company_name} - Competitors :::".colorize( :blue )
        blank
        company.print_competitors(@company_symbol)
        search_stock_options
      when "5"
        ### quote url
        puts_blanks
        puts "::: #{@company_name} - Financials :::".colorize( :blue )
        blank
        company.print_financials(@company_symbol)
        search_stock_options
      when "6"
        ### quote url
        puts_blanks
        puts "::: #{@company_name} - Profile :::".colorize( :blue )
        blank
        company.print_profile_info(@company_symbol)
        search_stock_options
      when "7"
        ### profile url
        puts_blanks
        puts "::: #{@company_name} - Company Description :::".colorize( :blue )
        blank
        company.print_company_description(@company_symbol)
        search_stock_options
      when "8"
        ### profile url
        puts_blanks
        puts "::: #{@company_name} - Company Contact Information :::".colorize( :blue )
        blank
        company.print_company_contact_info(@company_symbol)
        search_stock_options
      when "9"
        ### profile url
        puts_blanks
        puts "::: #{@company_name} - Shareholders :::".colorize( :blue )
        blank
        company.print_shareholders(@company_symbol)
        search_stock_options
      when "10"
        ### profile url
        puts_blanks
        puts "::: #{@company_name} - Top Executives :::".colorize( :blue )
        blank
        company.print_top_executives(@company_symbol)
        search_stock_options
      when "x"

      when "a"
        puts_blanks
        puts "::: #{@company_name} - Quick Facts :::".colorize( :blue )
        blank
        company.print_simple_performance(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Today's Trading Information :::".colorize( :blue )
        blank
        company.print_today_trading(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Growth & Valuation :::".colorize( :blue )
        blank
        company.print_growth(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Competitors :::".colorize( :blue )
        blank
        company.print_competitors(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Financials :::".colorize( :blue )
        blank
        company.print_financials(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Profile :::".colorize( :blue )
        blank
        company.print_profile_info(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Company Description :::".colorize( :blue )
        blank
        company.print_company_description(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Company Contact Information :::".colorize( :blue )
        blank
        company.print_company_contact_info(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Shareholders :::".colorize( :blue )
        blank
        company.print_shareholders(@company_symbol)

        puts_blanks
        puts "::: #{@company_name} - Top Executives :::".colorize( :blue )
        blank
        company.print_top_executives(@company_symbol)
        search_stock_options

      else
        puts_blanks
        puts "Not sure what you want, please pick an option from the menu.".colorize( :red )
        blank
        list_stock_search_menu
        search_stock_options
      end
    end
  end


  ##### COSMETIC METHODS #####


  def puts_blanks
    puts ""
    puts ""
    puts ""
    puts ""
    puts ""
    puts ""
  end

  def blank
    puts ""
  end

end


=begin
git add --all
git commit -m "modified: cli.rb"
git push

=end
