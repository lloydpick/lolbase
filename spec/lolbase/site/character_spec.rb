require 'spec_helper'

module Lolbase::Site::Character
  describe Base do
    subject { Base.new(fake_element, Lolbase::API.new()) }

    # Basics
    its(:id)     { should eql('EU19265646') }
    its(:name)   { should eql('Dux0r') }
    its(:level)  { should eql(30) }
    its(:region) { should eql('eu') }
    its(:url)    { should eql("/eu/Dux0r") }

    # Stats
    its(:normal_wins) { should eql(101) }
    its(:normal_wins_real) { should eql(354) }
    its(:normal_losses) { should eql(88) }
    its(:normal_losses_real) { should eql(243) }
    its(:normal_leaves) { should eql(0) }
    its(:normal_leaves_real) { should eql(1) }

    its(:ranked_wins) { should eql(6) }
    its(:ranked_wins_real) { should eql(18) }
    its(:ranked_losses) { should eql(7) }
    its(:ranked_losses_real) { should eql(9) }
    its(:ranked_leaves) { should eql(0) }
    its(:ranked_leaves_real) { should eql(1) }

    # Aliased methods
    its(:to_s)          { should eql('Dux0r') }
    its(:to_i)          { should eql(30) }
    its(:last_modified) { should_not be_nil }

    protected

    def fake_element
      html = Nokogiri::HTML(read_fixture('search_dux0r'))
      html.xpath('//div[@class="table"]/table/tbody/tr')
    end
  end
end