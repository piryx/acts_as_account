require "rubygems"
require "active_record"
ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + '/db/database.yml')['acts_as_account'])

require "lib/acts_as_account"

puts ARGV.inspect

if ARGV[0]
  if ARGV[0] == "create"
    ActsAsAccount::GlobalAccount.create(:name => "incoming").account
    ActsAsAccount::GlobalAccount.create(:name => "outgoing").account
    ActsAsAccount::GlobalAccount.create(:name => "revenue").account
  end
  puts "spin"
  until ActsAsAccount::GlobalAccount.find_by_name("wait")
    #spin...
  end
else
  puts "create"
  ActsAsAccount::GlobalAccount.create(:name => "wait")
end

start = Time.now

from_account = ActsAsAccount::Account.for("incoming")
to_account = ActsAsAccount::Account.for("outgoing")
rev_account = ActsAsAccount::Account.for("revenue")

puts "transactions"
100.times do
  ActiveRecord::Base.transaction do
    ActsAsAccount::Journal.current.transfer(100, from_account, to_account)
    ActsAsAccount::Journal.current.transfer(5, to_account, rev_account)
  end
end

puts "bye"
ActsAsAccount::GlobalAccount.find_by_name("wait").try(:destroy)

puts Time.now - start