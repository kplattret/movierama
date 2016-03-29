Resque.redis = Redis.new(url:  ENV.fetch('DB_URL'))
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
