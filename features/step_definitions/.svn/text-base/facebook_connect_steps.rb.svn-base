Given /^the following facebook_connects:$/ do |facebook_connects|
  FacebookConnect.create!(facebook_connects.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) facebook_connect$/ do |pos|
  visit facebook_connects_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following facebook_connects:$/ do |expected_facebook_connects_table|
  expected_facebook_connects_table.diff!(tableish('table tr', 'td,th'))
end
