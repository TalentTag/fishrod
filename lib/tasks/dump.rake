namespace :dump do
  
  desc "Dump search objects"
  task searches: :environment do
    File.open("#{ Rails.root }/tmp/searches.dump.yml", "w") do |o|
      items = Search.all.map(&:attributes)
      items.each { |i| i.delete 'id' }
      o.write(items.to_yaml)
    end
  end

end
