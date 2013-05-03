railsenv =  Rails.env == "production" ? "catchytune" : "catchytune-#{Rails.env}"
MongoMapper.database = railsenv