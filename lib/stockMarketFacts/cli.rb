class StockMarketFacts::CLI

  def call
    puts_blanks
    welcome
    # main_menu
    goodbye
  end

  def welcome
    puts "Welcome to Quick Stock Market Facts!".colorize( :blue )
    puts "Ready to get started? [y/n]"
    ready = gets.strip.downcase
    if ready == "y"
      main_menu
    end

  end

  def list_menu
    puts_blanks
    puts "::: MARKET MENU :::".colorize( :blue )
    blank
    choice_num = 1
    puts "What would you like to view about the market?"
    blank
    @@market_choices.each do |choice|
      puts "[#{choice_num}] #{choice[:title]}"
      choice_num += 1
    end

    puts "[a] to run all"
    puts "[s] Search by Stock Symbol"
    puts "[x] Exit Program"

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
  @@market_choices = [
    {title: "Most Popular Stocks", method_name: "popular_stocks"},
    {title: "Key Stats", method_name: "key_stats"},
    {title: "World Markets", method_name: "world_market"},
    {title: "Gainers", method_name: "gainers"},
    {title: "Losers", method_name: "losers"},
    {title: "Sector Performance", method_name: "sector_performance"},
    {title: "Commodities", method_name: "commodities"},
    {title: "How stocks are doing this year", method_name: "ytd_stock_performance"}
  ]

  list_menu
  @market = StockMarketFacts::Market.new


  while @input != 'x'
    @input = gets.strip.downcase
    puts_blanks
    if @input.to_i.between?(1, @@market_choices.length)
      user_choice = @@market_choices[@input.to_i - 1]
      puts "::: #{user_choice[:title]} :::".colorize( :blue )
      blank
      @market.print_market(user_choice[:method_name])
      options
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
          @@market_choices.each do |option|
            blank
            puts "::: #{option[:title]} :::".colorize( :blue )
            if option[:method_name]
              @market.print_market(option[:method_name])
            else
              puts "Coming Soon..."
            end
            blank
          end
          options

        else
          puts_blanks
          error_message
          list_menu
      end
    end
  end
  blank
  end

  #goodbye message when leaving app
  def goodbye
    puts_blanks
    puts "Have a great day!".colorize( :blue )
    puts "See you soon!".colorize( :blue )
    blank
    # @market.clear_data
  end

  def error_message
    puts "Not sure what you want, please pick an option from the menu.".colorize( :red )
  end

  #second level cli menu
  def list_stock_search_menu
    choice_num = 1
    puts_blanks
    puts "::: #{@company_name} STOCK MENU :::".colorize( :blue )
    blank
    puts "What would you like to view about #{@company_name}?"
    blank
    @@company_choices.each do |choice|
      puts "[#{choice_num}] #{choice[:title]}"
      choice_num += 1
    end

    puts "[a] to run all"
    puts "[x] Exit Program"
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
    @@company_choices = [
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


    while @input != 'x'
      @input = gets.strip.downcase
      if @input.to_i.between?(1, @@company_choices.length)
        puts_blanks
        user_choice = @@company_choices[@input.to_i - 1]
        puts "::: #{@company_name} - #{user_choice[:title]} :::".colorize( :blue )
        blank
        @company.send("print_#{user_choice[:method_name]}", @company_symbol)
        search_stock_options

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
            @@company_choices.each do |option|
              blank
              puts "::: #{option[:title]} :::".colorize( :blue )
              if option[:method_name]
                @company.send("print_#{option[:method_name]}", @company_symbol)
              else
                puts "Coming Soon..."
              end
              blank
            end
            search_stock_options

          else
            puts_blanks
            error_message
            list_menu
        end
      end
    end

  end


  ##### COSMETIC METHODS #####


  def puts_blanks
    puts "\n\n\n\n\n\n"
  end

  def blank
    puts "\n"
  end

end


=begin
git add --all
git commit -m "modified: cli.rb"
git push

=end
