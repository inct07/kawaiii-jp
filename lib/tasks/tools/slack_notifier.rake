require 'slack'

namespace :tools do
  namespace :slack_notifier do
    desc 'deploy開始をSlackに通知する'
    task deploy_start: :environment do
      slack_notifier('@here デプロイが始まったょ:heart:')
    end

    desc 'deploy完了をSlackに通知する'
    task deploy_finish: :environment do
      slack_notifier('@here デプロイがおわったょ:heart:')
    end

    private

    def slack_notifier(text)
      Slack.configure do |config|
        config.token = ENV['SLACK_API_TOKEN']
      end
      Slack.chat_postMessage(text: text,
                             link_names: 1,
                             username: '橋本環奈',
                             channel: "##{ENV['SLACK_NOTIFIER_CHANNEL']}",
                             icon_url: 'https://pbs.twimg.com/profile_images/790149435380539392/bzkT_r8q_400x400.jpg',
                             as_user: false)

    end
  end
end