Given /^I've created "([^\"]*)" post$/ do |title|
  Factory.create(:post, :title => title)
end

Given "there is no posts" do
  Post.destroy_all
end
