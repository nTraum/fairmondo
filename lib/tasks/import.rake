namespace :import do
  desc "Import content"
  task :content => :environment do
    CSV.foreach(ARGV[1], headers: true) do |row|
      hash_row = row.to_hash
      content_new = Content.find_or_create_by_key(hash_row["Key"])
      content_new.update_attributes(body: hash_row["Body"])
      content_new.save
    end
  end
  desc "Import categories"
  task :categories => :environment do
    CSV.foreach(ARGV[1], headers: true) do |row|
      hash_row = row.to_hash
      cat_new = Category.find_or_create_by_name(hash_row["Name"])
      cat_new.update_attributes(parent_id: hash_row["Parent id"])
    end
  end
end

