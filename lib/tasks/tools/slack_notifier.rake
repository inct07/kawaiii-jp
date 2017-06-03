require 'slack'

namespace :tools do
  namespace :slack_notifier do
    desc 'deploy完了をSlackに通知する'
    task deploy: :environment do
      Slack.configure do |config|
        config.token = ENV['SLACK_API_TOKEN']
      end
      Slack.chat_postMessage(text: '@here デプロイがおわったょ:heart:',
                             link_names: 1,
                             username: '橋本環奈',
                             channel: ENV['SLACK_NOTIFIER_CHANNEL'],
                             icon_url: 'https://pbs.twimg.com/profile_images/790149435380539392/bzkT_r8q_400x400.jpg',
                             as_user: false)
    end
  end
end