class User < ActiveRecord::Base
    attr_accessible :email, :homepage, :institution, :job_title, :name, :title, :password, :password_confirmation

    has_secure_password # pra fazer toda a criptografia da senha sozinho

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :name, presence: true
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true
    validates :password_confirmation, presence: true

    before_save { |user| user.email = email.downcase }
    before_save { generate_token(:remember_token) }

    private

        def generate_token(column)
            begin
                self[column] = SecureRandom.urlsafe_base64
            end while User.exists?(column => self[column])
        end
end
