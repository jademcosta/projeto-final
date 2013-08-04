class ApplicationController < ActionController::Base
  protect_from_forgery

  # helper_method :nome_do_metodo
  # para que o mteodo fique disponivel no application helper ;)
    
    helper_method :signed_in?, :current_user, :current_user?

    def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_path, notice: "Please, sign in."
		end
#		Aqui usamos uma versão resumida do código. Poderíamos ter usado:
#		flash[:notice] = "Please sign in."
#		redirect_to signin_path
#		o mesmo funciona pra :error, mas não para :success
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end
end
