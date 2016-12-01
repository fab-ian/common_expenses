module Api
  class UsersController < ApplicationController
    def available_users_item
      render(
        json: User.
          available_users_item(params[:id]).
          each do |rec|
            if rec.image.nil?
              rec.image = ActionController::Base.helpers.asset_path('no_picture.png')
            end
          end
      )
    end
  end
end
