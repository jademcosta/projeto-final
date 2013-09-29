class User < ActiveRecord::Base
    attr_accessible :email, :homepage, :institution, :job_title, :name, :title, :password, :password_confirmation, :image

    has_secure_password # pra fazer toda a criptografia da senha sozinho

    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id", 
		class_name: "Relationship",	dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower #nesse caso poderiamos tirar o source:
    has_many :inputs, dependent: :destroy

    mount_uploader :image, ImageUploader

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :name, presence: true
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    

    before_save { |user| user.email = email.downcase }
    before_save { generate_token(:remember_token) }


    def following?(other_user)
		relationships.find_by_followed_id(other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by_followed_id(other_user.id).destroy
	end

    def self.search(search, page)
        paginate :page => page, :conditions => ['name like ?', "%#{search}%"], :order => 'name'
    end

    private

        def generate_token(column)
            begin
                self[column] = SecureRandom.urlsafe_base64
            end while User.exists?(column => self[column])
        end
end
