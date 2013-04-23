raise Rails.env.inspect
MongoMapper.database = Rails.env == "production" ? "catchytune" : "catchytune-#{Rails.env}"