module RedmineHipchat
  module Patches
    module ProjectPatch
      def self.included(base)
        base.class_eval do
          safe_attributes 'hipchat_endpoint', 'hipchat_auth_token', 'hipchat_room_name', 'hipchat_notify'
        end
      end
    end
  end
end
