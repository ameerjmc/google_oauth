class Oauth < ApplicationRecord
 # Get access token 
 def self.googleAccessTokenCheckWithCode(code,redirect_uri)
	  
	    code = URI.decode(code)
	    user = Hash.new
	    begin
	     
	      params = {"code" => code, 'client_id' => '1234', "client_secret" => "1234" , "redirect_uri" => redirect_uri , "grant_type" => "authorization_code"}
	      response = RestClient.post 'https://www.googleapis.com/oauth2/v3/token', params
	      token_res = JSON.parse(response.body)
	      accessToken = token_res["access_token"]
	      user = googleAccessTokenCheck(accessToken)
	      return user
	    rescue Exception => e
	      user["message"] = e.message
	      user["status"] = false
	    end
	    return user

  end

 # Get user information
  def self.googleAccessTokenCheck(accessToken)
     
     require 'rest_client'
     response = ""
     user = Hash.new
     begin
	      response = RestClient.get 'https://www.googleapis.com/oauth2/v2/userinfo?token_type=Bearer&access_token='+ accessToken
	      if (response.code == 200)
	        user_deta = JSON.parse(response.body)
	        user["unique_id"] = user_deta["id"]
	        user["name"] = user_deta["name"]
	        user["email"] = user_deta["email"]
	        user["provider"] = "google"
	        user["access_token"] = accessToken
	        user["status"] = true
	      end
     rescue Exception => e
	       user["message"] = e.message
	       user["status"] = false
     end
    return user
  
  end

end
