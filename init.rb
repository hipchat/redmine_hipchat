Redmine::Plugin.register :redmine_hipchat do
  name 'HipChat'
  author 'HipChat, Inc.'
  description 'Sends notifications to a HipChat room.'
  version '2.0.0'
  url 'https://github.com/hipchat/redmine_hipchat'
  author_url 'https://www.hipchat.com/'

  Rails.configuration.to_prepare do
    require_dependency 'hipchat_hooks'
    require_dependency 'hipchat_view_hooks'
    require_dependency 'project_patch'
    Project.send(:include, RedmineHipchat::Patches::ProjectPatch)
  end

  settings :partial => 'settings/redmine_hipchat',
    :default => {
      :room_name => "",
      :auth_token => "",
      :endpoint => ""
    }
end
