require 'redmine'

require_dependency 'hipchat_hooks'

Redmine::Plugin.register :hipchat do
  name 'HipChat'
  author 'HipChat, Inc.'
  description 'Sends notifications to a HipChat room.'
  version '1.0.0'
  url 'https://github.com/hipchat/redmine_hipchat'

  settings :default => {
                         :room_id => "",
                         :auth_token => "",
                       },
           :partial => 'shared/settings'
end
