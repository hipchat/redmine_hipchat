HipChat Plugin for Redmine
==========================
Supports HipChat Server and HipChat API V2

This plugin sends messages to your HipChat room when issues are created or updated.

Setup
-----
```
cd REDMINE_ROOT
git clone https://github.com/wreiske/redmine_hipchat plugins/redmine_hipchat 
rake redmine:plugins:migrate RAILS_ENV=production
```


1. Clone this repo to Redmine's plugin directory (see above)
2. In Redmine, go to the Plugin page in the Adminstration area.
3. Select 'Configure' next to the HipChat plugin and enter the required details.
