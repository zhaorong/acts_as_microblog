class MicroblogGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "migrate/create_microblogs_and_microblog_followings.rb", "db/migrate", :migration_file_name => "create_microblogs_and_microblog_followings"
    end
  end
end
