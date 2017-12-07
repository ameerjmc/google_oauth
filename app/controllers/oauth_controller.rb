class OauthController < ApplicationController
  # Google oauth Api
  def google_oauth

	 	if params["code"].present? && params["redirect_url"].present?
            user_details = Oauth.googleAccessTokenCheckWithCode(params["code"],params["redirect_url"])
            render :json => user_details
	 	else
	 		render :json => {:status => false,:messsage => "Missing params"}
        end
  end

end
