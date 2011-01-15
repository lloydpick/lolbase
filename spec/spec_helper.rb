require 'lolbase'
require 'fakeweb'
require 'rspec'

def read_fixture(path)
  File.read(File.expand_path(File.join(File.dirname(__FILE__), "fixtures", path)))
end

WEB_SAMPLES = {
  "http://www.lolbase.net/eu/Limeh" => "profile_limeh",
  "http://www.lolbase.net/matches/player/EU19915678/all" => "match_list_limeh",
  "http://www.lolbase.net/rss/EU/Limeh" => "match_list_rss_limeh",
  "http://www.lolbase.net/matches/view/EU71617200" => "normal_match_win_limeh",
  "http://www.lolbase.net/matches/view/EU71639338" => "normal_match_loss_limeh",
  "http://www.lolbase.net/eu/Dux0r" => "profile_dux0r",
  "http://www.lolbase.net/matches/player/EU19265646/all" => "match_list_dux0r",
  "http://www.lolbase.net/rss/EU/Dux0r" => "match_list_rss_dux0r",
  "http://www.lolbase.net/matches/view/EUr22724901" => "ranked_match_win_dux0r",
  "http://www.lolbase.net/matches/view/EUr20418060" => "ranked_match_loss_dux0r"
}

Rspec.configure do |config|
  config.mock_with :mocha
  config.before(:all) do
    FakeWeb.allow_net_connect = false
    WEB_SAMPLES.each do |url, response|
      FakeWeb.register_uri(:get, url, :response => read_fixture(response))
    end
  end
end