class NotificationHook < Redmine::Hook::Listener

  def controller_issues_new_after_save(context={})
    issue = context[:issue]
    author = CGI::escapeHTML(issue.author.name)
    tracker = CGI::escapeHTML(issue.tracker.name.downcase)
    subject = CGI::escapeHTML(issue.subject)
    url = get_url issue.id
    text = "#{author} reported #{tracker} <a href=\"#{url}\">##{issue.id}</a>: #{subject}"

    send_message text
  end

  def controller_issues_edit_after_save(context={})
    issue = context[:issue]

    author = CGI::escapeHTML(issue.author.name)
    tracker = CGI::escapeHTML(issue.tracker.name.downcase)
    subject = CGI::escapeHTML(issue.subject)
    url = get_url issue.id
    text = "#{author} updated #{tracker} <a href=\"#{url}\">##{issue.id}</a>: #{subject}"

    send_message text
  end

private

  def get_url(issue_id)
    return "#{Setting[:protocol]}://#{Setting[:host_name]}/issues/#{issue_id}"
  end

  def send_message(message)
    if Setting.plugin_hipchat[:auth_token].empty? || Setting.plugin_hipchat[:room_id].empty?
      RAILS_DEFAULT_LOGGER.info "Not sending HipChat message - missing config"
      return
    end

    RAILS_DEFAULT_LOGGER.info "Sending message to HipChat: #{message}"
    req = Net::HTTP::Post.new("/v1/rooms/message")
    req.set_form_data({
      :auth_token => Setting.plugin_hipchat[:auth_token],
      :room_id => Setting.plugin_hipchat[:room_id],
      :notify => Setting.plugin_hipchat[:notify] ? 1 : 0,
      :from => 'Redmine',
      :message => message
    })
    req["Content-Type"] = 'application/x-www-form-urlencoded'

    http = Net::HTTP.new("api.hipchat.com", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    begin
      http.start do |connection|
        connection.request(req)
      end
    rescue Net::HTTPBadResponse => e
      RAILS_DEFAULT_LOGGER.error "Error hitting HipChat API: #{e}"
    end
  end

end
