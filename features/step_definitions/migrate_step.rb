Given /^these following articles exist$/ do |articles_table|
	articles_table.hashes.each do |art|
		Article.create!(art)
	end
end

Given /^these following users exist$/ do |users_table|
	users_table.hashes.each do |user|
		User.create!(user)
	end
end


Given /^these following comments exist$/ do |comments_table|
	comments_table.hashes.each do |comment|
		Comment.create(comment)
	end
end


Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
	visit '/accounts/login'
	fill_in 'user_login', :with => username
	fill_in 'user_password', :with => password
	click_button 'Login'
	if page.respond_to? :should
		page.should have_content('Login successful')
	else
		assert page.has_content?('Login successful')
	end
end

Given /^"([^"]*)" is merged with "([^"]*)"$/ do |art1, art2|
	step "I am logged into the admin panel"
	a1 = Article.find_by_title(art1)
	a2 = Article.find_by_title(art2)
	a1.merge_with(a2)
end

Then /^"([^"]*)" has (\d) article$/ do |username, numOfArt|
	user = User.find_by_login(username)
	user.articles.count.should == numOfArt.to_i
end
