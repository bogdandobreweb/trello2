class ApplicationController < ActionController::Base
    include Pundit::Authorization
    skip_before_action :verify_authenticity_token

    def append_info_to_payload(payload)
        super
        payload[:user_id] = current_user.id if current_user
      end
end
