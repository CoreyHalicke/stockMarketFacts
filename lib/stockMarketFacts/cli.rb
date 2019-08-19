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

  choices = [
    {title: "Most Popular Stocks", method_name: "popular_stocks"},
    {title: "Key Stats", method_name: "key_stats"},
    {title: "World Markets", method_name: "world_market"},
    {title: "Gainers", method_name: "gainers"},
    {title: "Losers", method_name: "losers"},
    {title: "Sector Performance", method_name: "sector_performance"},
    {title: "Commodities", method_name: "commodities"},
    {title: "How stocks are doing this year", method_name: "ytd_stock_performance"}
  ]

  while @input != 'x'
    @input = gets.strip.downcase
    puts_blanks
    if @input.to_i.between?(1, choices.length)
      user_choice = choices[@input.to_i - 1]
      puts "::: #{user_choice[:title]} :::".colorize( :blue )
      blank
      @market.print_market(user_choice[:method_name])
    else
      case @input
        when "m"
          main_menu

        when "s"
          puts "::: Search by Stock Symbol :::".colorize( :blue )
          blank
          puts "Type in the Stock Symbol for the Company you are looking for:"
          search_stock_menu

        when "x"

        when "a"
          choices.each do |option|
            blank
            puts "::: #{option[:title]} :::".colorize( :blue )
            if option[:method_name]
              @market.print_market(option[:method_name])
            else
              puts "Coming Soon..."
            end
            blank
          end

        else
          puts_blanks
          error_message
          list_menu
      end
    end
    options
  end
  blank
  end

  #goodbye message when leaving app
  def goodbye
    puts_blanks
    puts "Thank you for using Quick Stock Market Facts!".colorize( :blue )
    puts "See you soon!".colorize( :blue )
    blank
    # @market.clear_data
  end

  def error_message
    puts "Not sure what you want, please pick an option from the menu.".colorize( :red )
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
    @company = StockMarketFacts::Company.new(@company_symbol)
    #needs to validate stock symbol input
    quote_doc = @company.pull_quote_data(@company_symbol)

    until quote_doc.css("h1").text != "Symbol not found"
      puts "Please enter a valid Stock Symbol.".colorize( :red )
      @company_symbol = gets.strip.upcase
      quote_doc = @company.pull_quote_data(@company_symbol)
    end

    @company_name = quote_doc.css("h1").text

    list_stock_search_menu

    choices = [
      {title: "Quick Facts", method_name: "simple_performance"},
      {title: "Today's Trading Information", method_name: "today_trading"},
      {title: "Growth & Valuation", method_name: "growth"},
      {title: "Competitors", method_name: "competitors"},
      {title: "Financials", method_name: "financials"},
      {title: "Profile", method_name: "profile_info"},
      {title: "Company Description", method_name: "company_description"},
      {title: "Company Contact Information", method_name: "company_contact_info"},
      {title: "Shareholders", method_name: "shareholders"},
      {title: "Top Executives", method_name: "top_executives"},
    ]

    while @input != 'x'
      @input = gets.strip.downcase
      if @input.to_i.between?(1, choices.length)
        puts_blanks
        user_choice = choices[@input.to_i - 1]
        puts "::: #{@company_name} - #{user_choice[:title]} :::".colorize( :blue )
        blank
        @company.send("print_#{user_choice[:method_name]}", @company_symbol)
      else
        case @input
          when "m"
            main_menu

          when 'b'
            list_stock_search_menu

          when "s"
            puts "::: Search by Stock Symbol :::".colorize( :blue )
            blank
            puts "Type in the Stock Symbol for the Company you are looking for:"
            search_stock_menu

          when "x"

          when "a"
            choices.each do |option|
              blank
              puts "::: #{option[:title]} :::".colorize( :blue )
              if option[:method_name]
                @company.send("print_#{option[:method_name]}", @company_symbol)
              else
                puts "Coming Soon..."
              end
              blank
            end

          else
            puts_blanks
            error_message
            list_menu
        end
      end
      search_stock_options
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
