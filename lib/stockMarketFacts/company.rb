class StockMarketFacts::Company

  attr_accessor :simple_performance, :today_trading, :growth, :competitors, :financials, :profile_info, :company_description, :company_contact, :shareholders, :top_executives

  #create new object for a company
  def initialize(company_symbol)
    @simple_performance = []
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

  ## do i want to store past data in @@all?

  ##### DATA PULLS #####

  #pull data from quote url for given company
  def pull_quote_data(company_symbol)
    quote_url = "https://money.cnn.com/quote/quote.html?symb=#{company_symbol}"
    @quote_doc = Nokogiri::HTML(open(quote_url))
  end

  #pull data from profile url for given company
  def pull_profile_data(company_symbol)
    profile_url = "https://money.cnn.com/quote/profile/profile.html?symb=#{company_symbol}"
    @profile_doc = Nokogiri::HTML(open(profile_url))
  end


  ##### GRAB DATA #####

  def grab_simple_performance
    #find data
    current_price = @quote_doc.css("td.wsod_last span")[0].text
    todays_change_dollar = @quote_doc.css("td.wsod_change span")[1].text
    todays_change_percent = @quote_doc.css("td.wsod_change span")[2].text
    ytd_change = @quote_doc.css("td.wsod_ytd span").text
    # simple_performance_last_updated = @quote_doc.css("td.wsod_last span")[1].text

    #add data to array
    @simple_performance << [
      current_price,
      todays_change_dollar,
      todays_change_percent,
      ytd_change,
      # simple_performance_last_updated
    ]
  end

  def grab_today_trading
    #find data
    today_trading1 = @quote_doc.css("div.clearfix.wsod_DataColumnLeft")[0]
    today_trading2 = today_trading1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    # @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    today_trading2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @today_trading << [title, data]
    end
  end

  def grab_growth
    #find data
    growth1 = @quote_doc.css("div.clearfix.wsod_DataColumnRight")[0]
    growth2 = growth1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    # @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    growth2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @growth << [title, data]
    end
  end

  def grab_competitors
    #find data
    competitors1 = @quote_doc.css("div.clearfix.wsod_DataColumnLeft")[1]
    competitors2 = competitors1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    # @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    counter = 1
    competitors2.each do |x|
      if counter == 1
        counter += 1
      else
        counter += 1
        symbol = x.css("a.wsod_symbol").text
        title = x.css("span")[0].text
        todays_change = x.css("span")[1].text
        todays_percent_change = x.css("span")[2].text

        @competitors << [symbol, title, todays_change, todays_percent_change]
      end
    end
  end

  def grab_financials
    #find data
    financials1 = @quote_doc.css("div.clearfix.wsod_DataColumnRight")[1]
    financials2 = financials1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    # @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    financials2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @financials << [title, data]
    end
  end

  def grab_profile_info
    #find data
    profile_info1 = @quote_doc.css("div.clearfix.wsod_DataColumnLeft")[2]
    profile_info2 = profile_info1.css("tr")
    date_container = @quote_doc.css("div.clearfix.wsod_quoteDetails.wsod_containerSpacing")
    # @last_update_today_trading_and_growth = date_container.css("div.wsod_fRight")[0].text

    #add data to array
    profile_info2.each do |x|
      title = x.css("div.wsod_fLeft").text
      data = x.css("div.wsod_fRight.wsod_bold").text
      @profile_info << [title, data]
    end
  end

  def grab_company_description
    #find data
    company_description = @profile_doc.css("div#wsod_companyDescription").text
    @company_description << company_description
  end

  def grab_company_contact_info
    #find data
    company_contact1 = @profile_doc.css("div.wsod_companyContactInfo.wsod_companyNameStreet")
    company_contact2 = @profile_doc.css("div.wsod_companyContactInfo.wsod_companyPhoneURL")
    title = ""
    street_address = ""
    street_address2 = ""
    phone = ""
    phone1 = ""
    phone2 = ""
    website = ""

    #add data to array
    company_contact1.each do |x|
      title = x.css("div")[0].text
      street_address = x.css("div")[1].text
      street_address2 = x.css("div")[2].text
    end

    company_contact2.each do |x|
      phone = x.css("div")[0].text
      phone1 = x.css("div")[1].text
      website = x.css("div")[2].text
    end
    @company_contact << [title, street_address, street_address2, phone, phone1, website]
  end

  def grab_shareholders
    #find data
    shareholders = @profile_doc.css("table.wsod_dataTableSmallNoBorder")
    shareholders2 = shareholders.css("tr")

    #add data to array
    shareholders2.each do |x|
      name = x.css("td")[0].text
      percent = x.css("td")[1].text
      @shareholders << [name, percent]
    end
  end

  def grab_top_executives
    #coming soon
  end




  ##### PRINT METHODS #####

  def print_company(choice)


  end

  def print_simple_performance(company_symbol)
    clear_data
    pull_quote_data(company_symbol)
    grab_simple_performance

    @simple_performance.each do |item|
      line_break
      puts "Price: #{item[0].colorize( :blue )}"
      line_break
      puts "Today's Dollar Change: #{item[1].colorize( :blue )}"
      line_break
      puts "Today's Percent Change: #{item[2].colorize( :blue )}"
      line_break
      puts "YTD Change #{item[3].colorize( :blue )}"
      # line_break
      # puts "Last Updated: #{item[4]}"
    end
    line_break
  end

  def print_today_trading(company_symbol)
    clear_data
    pull_quote_data(company_symbol)
    grab_today_trading

    @today_trading.each do |item|
      line_break
      puts "#{item[0]} => #{item[1].colorize( :blue )}"
    end
    line_break
    # puts @last_update_today_trading_and_growth
    # line_break
  end

  def print_growth(company_symbol)
    clear_data
    pull_quote_data(company_symbol)
    grab_growth

    @growth.each do |item|
      line_break
      puts "#{item[0]} => #{item[1].colorize( :blue )}"
    end
    line_break
    # puts @last_update_today_trading_and_growth
    # line_break
  end

  def print_competitors(company_symbol)
    clear_data
    pull_quote_data(company_symbol)
    grab_competitors

    @competitors.each do |item|
      line_break
      puts "#{item[0].colorize( :blue )} - #{item[1].colorize( :blue )} =>"
      puts "Today's Change: #{item[2].colorize( :blue )} | Today's Percent Change: #{item[3].colorize( :blue )}"
    end
    line_break
    # puts @last_update_today_trading_and_growth
    # line_break
  end

  def print_financials(company_symbol)
    clear_data
    pull_quote_data(company_symbol)
    grab_financials

    @financials.each do |item|
      line_break
      puts "#{item[0]} => #{item[1].colorize( :blue )}"
    end
    line_break
    # puts @last_update_today_trading_and_growth
    # line_break
  end

  def print_profile_info(company_symbol)
    clear_data
    pull_quote_data(company_symbol)
    grab_profile_info

    @profile_info.each do |item|
      line_break
      puts "#{item[0]} => #{item[1].colorize( :blue )}"
    end
    line_break
  end

  def print_company_description(company_symbol)
    clear_data
    pull_profile_data(company_symbol)
    grab_company_description

    line_break
    puts @company_description[0]
    line_break
  end

  def print_company_contact_info(company_symbol)
    clear_data
    pull_profile_data(company_symbol)
    grab_company_contact_info

    line_break
    @company_contact.each do |item|
      puts "#{item[0].colorize( :blue )}"
      puts "#{item[1]}"
      puts "#{item[2]}"
      puts "#{item[3]}"
      puts "#{item[4]}"
      puts "#{item[5]}"
    end
    line_break

  end

  def print_shareholders(company_symbol)
    clear_data
    pull_profile_data(company_symbol)
    grab_shareholders

    @shareholders.each do |item|
      line_break
      puts "#{item[0].colorize( :blue )}:  #{item[1]}"
    end
    line_break
  end

  def print_top_executives(company_symbol)
    clear_data
    pull_profile_data(company_symbol)
    grab_top_executives

    puts "Coming Soon..."
  end






  ##### COSMETIC METHODS #####

  def line_break
    puts "________________________________________________________________________________"
  end

  #clear all object data
  def clear_data
    @simple_performance = []
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
git commit -m "modified: condensing code"
git push

=end
