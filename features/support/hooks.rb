Before do
  DatabaseCleaner.start
end

After do
  ActsAsAccount::Journal.clear_current
  DatabaseCleaner.clean
end