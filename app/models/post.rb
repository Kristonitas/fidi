class Post < ActiveRecord::Base
	enum category: [ :dienine, :eisena, :vakarine ]
end
