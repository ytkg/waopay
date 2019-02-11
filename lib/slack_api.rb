require 'slack'
module SlackApi
  def self.post_message(text, channel: '#waopay_orders', username: 'wao:Pay Order', icon_emoji: ':waopay:')
    if Rails.env.production?
      Slack.configure do |config|
        config.token = ENV['SLACK_TOKEN']
      end
      Slack.chat_postMessage text: text, channel: channel, username: username, icon_emoji: icon_emoji
    else
      puts "Post to Slack:\n#{text}"
    end
  end
end
