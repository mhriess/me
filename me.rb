require 'singleton'
require 'twitter'

class Me
	# There can only be one!
	include Singleton

	def tweets
		puts "My five most recent tweets:"
		puts
		puts Twitter.tweets.map.with_index { |t, i| (i + 1).to_s + '. ' + t.text }.join("\n\n")
	end
end

module Twitter
  HANDLE = 'mhriess'

  class << self
    # @return my 5 most recent tweets
	  def tweets
      client.user_timeline(HANDLE)[0..4]
	  end

	  def client
		  @client ||= Twitter::REST::Client.new do |config|
			  config.consumer_key        = ENV['CONSUMER_KEY']
			  config.consumer_secret     = ENV['CONSUMER_SECRET']
			  config.access_token        = ENV['ACCESS_TOKEN']
			  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
			end
		end
	end
end