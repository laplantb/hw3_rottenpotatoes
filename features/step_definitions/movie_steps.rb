# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.text.include?(e1), e1 + " is not in page content"
  assert page.text.include?(e2), e2 + " is not in page content"
  assert page.text.index(e1) < page.text.index(e2), "Movie " + e1 + " is not before " + e2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |rating|
     step "I " + (uncheck ? "uncheck" : "check") + " \"ratings[" + rating + "]\""
  end
end

Then /I should see all of the movies/ do
  Movie.find(:all).each do |movie|
     step "I should see \"" + movie.title + "\""
  end
end

Then /I should not see any movie/ do
  Movie.find(:all).each do |movie|
     step "I should not see \"" + movie.title + "\""
  end
end
