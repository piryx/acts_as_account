require 'test/unit/assertions'
require 'active_record'

World(Test::Unit::Assertions)

ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + '/../../db/database.yml')['acts_as_account'])

require File.dirname(__FILE__) + '/../../lib/acts_as_account'

#ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :truncation

Dir[File.dirname(__FILE__) + '/../step_definitions/*.rb'].each { |file| require file }

require File.dirname(__FILE__) + '/user'
require File.dirname(__FILE__) + '/cheque'

