namespace :db do
  desc "Checks to see if the database and the main model records exist"
  task :exists do
    begin
      unless Rake::Task['environment'].invoke 
        ActiveRecord::Base.connection
        exit 1
      end

      unless Article.exists? && Category.exists? && Subcategory.exists? &&
             Newsletter.exists? && Team.exists? && User.exists?
        puts "One or more required models records do not exist."
        exit 1
      end

      puts "Database and main model records exist."
      exit 0

    rescue => e
      puts "Error: #{e.message}"
      exit 1
    end
  end
end