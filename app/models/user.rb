class User < ActiveRecord::Base
	attr_accessor :password
	before_save :encrypt_password
		
	has_many :posts
	belongs_to :group

	attr_accessible :email, :password, :password_confirmation
	#from RailsCasts
	# walidacje sa po stronie modelu ale odnosza sie do proby zapisania rekordu z forma registration form dla userow bez wypelnienia odpowiednich pol - czyli rekordu w bazie w ktorym nie wszystko jest wypelnione
	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	
	#metoda authenticate jest przeniesiona do modelu - ze wzgledu na to ze odnosi sie do komunikacji z baza danych i sprawdzaniem userow, ale takze tego ze integralnie laczy sie z sesjami i innymi mechanizmami storowania danych 
	def self.authenticate(username, password)
		user = find_by_username(username)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) #weryfikuj po username i password czy istnieje user oraz czy hash hasla sie zgadza z wynikiem dzialania metody enkryptujacej z zadanym saltem ; te dane sa populowane w momencie gdy przy probie zapisania usera wywolywana jest metoda encrypt_password
		user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
