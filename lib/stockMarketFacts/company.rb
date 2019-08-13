class StockMarketFacts::Company

  attr_accessor :simple_performace, :today_trading, :growth, :competitors, :financials, :profile_info, :company_description, :company_contact, :shareholders, :top_executives

  def initialize(company_symbol)
    @simple_performace
    @today_trading
    @growth
    @competitors
    @financials
    @profile_info
    @company_description
    @company_contact
    @shareholders
    @top_executives
    self.fill_data(company_symbol)
  end

  def fill_data(company_symbol)
    quote_url = "https://money.cnn.com/quote/quote.html?symb=#{company_symbol}"
    profile_url = "https://money.cnn.com/quote/profile/profile.html?symb=#{company_symbol}"
    quote_doc = Nokogiri::HTML(open(quote_url))
    profile_doc = Nokogiri::HTML(open(profile_url))
    binding.pry
  end



end




=begin
git add --all
git commit -m "modified: company.rb"
git push

=end
