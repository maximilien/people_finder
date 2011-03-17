namespace :pfif do
  desc "Runs all pfif tests"
  Rake::TestTask.new do |t|
    root_dir = File.dirname(__FILE__) + '/..'
    ["#{root_dir}/lib", "#{root_dir}/test"].each{|dir| t.libs << dir}
    t.test_files = FileList["#{root_dir}/test/*_test.rb"]
    t.verbose = true
  end
end