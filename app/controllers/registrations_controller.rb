# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def cancel_account
    current_user.update_attribute(:blocked, true)
    sign_out
    redirect_to new_user_session_path
  end
end
