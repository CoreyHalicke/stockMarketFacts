class StockMarketFacts::Company

  attr_accessor :simple_performace, :today_trading, :growth, :competitors, :financials, :profile_info, :company_description, :company_contact, :shareholders, :top_executives

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
    self.fill_data(company_symbol)
  end

  def fill_data(company_symbol)
    quote_url = "https://money.cnn.com/quote/quote.html?symb=#{company_symbol}"
    profile_url = "https://money.cnn.com/quote/profile/profile.html?symb=#{company_symbol}"
    quote_doc = Nokogiri::HTML(open(quote_url))
    profile_doc = Nokogiri::HTML(open(profile_url))



    #fill simple performance
    current_price = quote_doc.css("td.wsod_last span")[0].text
    todays_change_dollar = quote_doc.css("td.wsod_change span")[1].text
    todays_change_percent = quote_doc.css("td.wsod_change span")[2].text
    ytd_change = quote_doc.css("td.wsod_ytd span").text
    simple_performace_last_updated = quote_doc.css("td.wsod_last span")[1].text
    @simple_performace << [current_price, todays_change_dollar, todays_change_percent, ytd_change, simple_performace_last_updated]


    #fill today's trading info
    today_trading1 = quote_doc.css("div.clearfix.wsod_DataColumnLeft")[0]
    today_trading2 = today_trading1.css("tr")
    today_trading2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @today_trading << [title, data]
    end

    #fill growth
    growth1 = quote_doc.css("div.clearfix.wsod_DataColumnRight")[0]
    growth2 = growth1.css("tr")
    growth2.each do |x|
      title = x.css("td")[0].text
      data = x.css("td")[1].text
      @growth << [title, data]
    end







  end


  def print_simple_performance
    @simple_performace.each do |item|
      puts "Price: #{item[0]} | Today's Dollar Change: #{item[1]} | Today's Percent Change: #{item[2]} | YTD Change #{item[3]} | Last Updated: #{item[4]}"
    end
  end

  def print_today_trading
    @today_trading.each do |item|
      puts "#{item[0]} => #{item[1]}"
    end
  end

  def print_growth
    @growth.each do |item|
      puts "#{item[0]} => #{item[1]}"
    end

  end

end




=begin
git add --all
git commit -m "modified: company.rb"
git push

=end
