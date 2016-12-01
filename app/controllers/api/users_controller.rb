module Api
  class UsersController < ApplicationController
    def available_users_item
      render(
        json: User.
          available_users_item(params[:id]).
          each { |rec| rec.image = '/assets/no_picture.png' if rec.image.nil? }
      )
    end
  end
end
