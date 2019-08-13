class StockMarketFacts::Company

  attr_accessor :simple_performace, :today_trading, :growth, :competitors, :financials, :profile_info, :company_description, :company_contact, :shareholders, :top_executives

  #create new object for a company
  def initialize(company_symbol)
    @simple_performace = []
    @today_trading = []
    @growth = []
    @competitors = []
    @financials = []
    @profile_info = []
    @company_description = []
    @company_contact = []
    @shareholders = []
    @top_executives = []
  end

  #pull data from quote page for given company
  def pull_quote_data(company_symbol)
    quote_url = "https://money.cnn.com/quote/quote.html?symb=#{company_symbol}"
    @quote_doc = Nokogiri::HTML(open(quote_url))
  end

  #pull data from profile page for given company
  def pull_profile_data(company_symbol)
    profile_url = "https://money.cnn.com/quote/profile/profile.html?symb=#{company_symbol}"
    @profile_doc = Nokogiri::HTML(open(profile_url))
  end

  #clear, pull updated data, store data, print data
  def print_simple_performance(company_symbol)
    clear_data
    pull_quote_data(company_symbol)

    #find data
    current_price = @quote_doc.css("td.wsod_last span")[0].text
    todays_change_dollar = @quote_doc.css("td.wsod_change span")[1].text
    todays_change_percent = @quote_doc.css("td.wsod_change span")[2].text
    ytd_change = @quote_doc.css("td.wsod_ytd span").text
    simple_performace_last_updated = @quote_doc.css("td.wsod_last span")[1].text

    #add data to array
    @simple_performace << [current_price, todays_change_dollar, todays_change_percent, ytd_change, simple_performace_last_updated]

    #print data to terminal
    @simple_performace.each do |item|
      line_break
      puts "Price: #{item[0].colorize( :blue )}"
      line_break
      puts "Today's Dollar Change: #{item[1].colorize( :blue )}"
      line_break
      puts "Today's Percent Change: #{item[2].colorize( :blue )}"
      line_break
      puts "YTD Change #{item[3].colorize( :blue )}"
      line_break
      puts "Last Updated: #{item[4]}"
    end
    line_break
  end

  #clear, pull updated data, store data, print data
  def print_today_trading(company_symbol)
    clear_data
    pull_quote_data(company_symbol)

    #find data
    today_trading1 = @quote_doc.css("div.clearfix.wsod_DataColumnLeft")[0]
    today_trading2 = today_trading1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    today_trading2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @today_trading << [title, data]
    end

    #print data to terminal
    @today_trading.each do |item|
      line_break
      puts "#{item[0]} => #{item[1].colorize( :blue )}"
    end
    line_break
    puts @last_update_today_trading_and_growth
    line_break
  end

  #clear, pull updated data, store data, print data
  def print_growth(company_symbol)
    clear_data
    pull_quote_data(company_symbol)

    #find data
    growth1 = @quote_doc.css("div.clearfix.wsod_DataColumnRight")[0]
    growth2 = growth1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    growth2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @growth << [title, data]
    end

    #print data to terminal
    @growth.each do |item|
      line_break
      puts "#{item[0]} => #{item[1].colorize( :blue )}"
    end
    line_break
    puts @last_update_today_trading_and_growth
    line_break
  end

  #clear, pull updated data, store data, print data
  def print_competitors(company_symbol)
    clear_data
    pull_quote_data(company_symbol)

      #find data

      #add data to array

      #print data to terminal
      puts "Coming Soon..."
  end

  #clear, pull updated data, store data, print data
  def print_financials(company_symbol)
    clear_data
    pull_quote_data(company_symbol)

    #find data

    #add data to array

    #print data to terminal
    puts "Coming Soon..."
  end






  def line_break
    puts "---------------------------------------------------------------"
  end

  #clear all object data
  def clear_data
    @simple_performace = []
    @today_trading = []
    @growth = []
    @competitors = []
    @financials = []
    @profile_info = []
    @company_description = []
    @company_contact = []
    @shareholders = []
    @top_executives = []
  end

end




=begin
git add --all
git commit -m "modified: company.rb"
git push

=end
