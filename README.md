# README

### Google Oauth without any Library Files :smiley: :
   
    
![Alt text](https://github.com/ameerjmc/google_oauth/blob/master/google.png)


Steps:

1.Go to https://console.developers.google.com

2.Create New Project

3.Get your app client_id and client_secret id


### Google Login for Web and Mobile Devices Using Ruby on Rails :

include the gem in your Gemfile:

<body>

    gem 'rest-client'
    
</body>


And then execute:

 $ bundle install
   
Steps:

1.rails g model oauth

2.rake db:migrate

3.rails g controller oauth google_oauth


## google_oauth Functions :

 Oauth.rb File

<body>

	 # Get accesstoken 
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
  
    # Get information 
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


</body>

  routes.rb File:

<body>

    post 'oauth' => "oauth#google_oauth"
  
</body>


### Sample Response :

![Alt text](https://github.com/ameerjmc/google_oauth/blob/master/res.jpg)







	





