# Scenario: Visit an article page as a guest user
When('I visit an article with this headline:') do |table|
  attributes = table.rows_hash
  article = FactoryBot.create(:article, headline: attributes[:Headline])
  visit article_path(article)
end

Then('I should have an article with that headline:') do |table|
  attributes = table.rows_hash
  expect(page).to have_content(attributes[:Headline])
end

Then('I should not be able to see a comment form') do
  expect(page).not_to have_selector "#comment-general-form"
end


# Scenario: Visit an article and leave a comment as logged-in user
When('I log in as a user with name:') do |table|
  attributes = table.rows_hash
  user = FactoryBot.create(:user, name: attributes[:Name])
  login_as user
end

Then('I visit an article') do
  article = FactoryBot.create(:article)
  visit article_path(article)
end

Then('I should be able to see a comment form') do
  page.find("#comment-general-form")
end

When('I comment on the article with:') do |table|
  attributes = table.rows_hash
  fill_in "comment[content]", with: attributes[:Content]
  click_button('Submit')
end

Then("I sort the comments by 'Most recent'") do
  select('Most Recent', from: 'sort_by')
end

Then('I should see at the top a comment with these attributes:') do |table|
  attributes = table.rows_hash
  comment = page.find(".comment", match: :first)

  expect(comment.find('.comment-content')).to have_content(attributes['Content'])
  expect(comment.find('.comment-author')).to  have_content(attributes['User name'])
end
