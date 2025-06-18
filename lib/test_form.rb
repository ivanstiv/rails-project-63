require 'ostruct'
require_relative 'hexlet_code'

user = OpenStruct.new(name: "rob", job: "hexlet")

form_html = HexletCode.form_for(user) do |f|
  f.input :name, label: "Name", class: "user-input"
  f.input :job, label: "Job", as: :text
  f.submit "Wow"
end

puts form_html