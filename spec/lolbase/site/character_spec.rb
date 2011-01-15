require 'spec_helper'

module Lolbase::Site::Character
  describe Base do
    subject { Base.new(fake_element, Lolbase::API.new()) }

    its(:id)     { should eql('EU19915678') }
    its(:name)   { should eql('Limeh') }
    its(:level)  { should eql(30) }
    its(:region) { should eql('eu') }
    its(:url)    { should eql("/eu/Limeh") }

    # Aliased methods
    its(:to_s)          { should eql('Limeh') }
    its(:to_i)          { should eql(30) }
    its(:last_modified) { should_not be_nil }

    protected

    def fake_element
      html = Nokogiri::HTML(read_fixture('search_limeh'))
      html.xpath('//div[@class="table"]/table/tbody/tr')[3]
    end
  end
end