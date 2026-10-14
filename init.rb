require 'redmine'

require File.expand_path(
  'app/helpers/time_loggers_helper',
  __dir__
)

ApplicationController.helper(TimeLoggerApplicationHelper)

# Some Redmine controllers may already have built their own helper module.
# Add the helper explicitly to those too.
ApplicationController.descendants.each do |controller|
  next unless controller.respond_to?(:helper)

  controller.helper(TimeLoggerApplicationHelper)
end

require File.expand_path(
  'lib/time_logger_hooks',
  __dir__
)

Redmine::Plugin.register :time_logger do
  name 'Time Logger'
  author 'Jim McAleer'
  description 'The orignal author was Jérémie Delaitre.'
  url 'https://github.com/speedy32129/time_logger'
  version '0.6.0'

  # fix for contect menus

  requires_redmine :version_or_higher => '3.0.0'

  settings default: { refresh_rate: '60', status_transitions: {}, redirect_to_new_time_entry: 'off' }, partial: 'settings/time_logger'

  permission :view_others_time_loggers, time_loggers: :index
  permission :delete_others_time_loggers, time_loggers: :delete

  menu :account_menu, :time_logger_menu, 'javascript:void(0)',
       caption: '',
       html: { id: 'time-logger-menu' },
       first: true,
       param: :project_id,
       if: proc { User.current.logged? }
end
