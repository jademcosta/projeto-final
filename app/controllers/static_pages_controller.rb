# encoding: utf-8

class StaticPagesController < ApplicationController
   
    def home
        if signed_in?
            ids_of_followed_users = current_user.followed_user_ids
            @inputs = Input.where(:user_id => ids_of_followed_users)
            #puts ">>>>>>>>>>>>>>>>>>>>>>>> #{ids_of_followed_users} com #{@inputs.count}"
            @inputs.each { |inp| puts inp.class }
        end
    end
    
    def contact
    end
end
