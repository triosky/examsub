# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'

def seed_json path
  file = File.read(path)
  jsonData = JSON.parse(file)
  jsonData.each do |data|
    data["exams"].each do |d|
      if d != {}
        ExamList.create(:vendor_name => data["name"], :exam_code => d["code"], :exam_lang => d["lang"], :exam_title => d["title"], :exam_time => d["time"], :exam_cost => d["cost"])
      end
    end
  end
end

ExamList.delete_all
seed_json("#{Rails.root}/public/website1.json")
seed_json("#{Rails.root}/public/website2.json")

list = []
ExamList.all.each do |examlist|
  if examlist.exam_code
    list << "#{examlist.exam_code}:#{examlist.exam_title}"
  else
    list << examlist.exam_title
  end
end
File.open("#{Rails.root}/public/autocomplete.yml", 'w') {|f| f.write list.to_yaml }