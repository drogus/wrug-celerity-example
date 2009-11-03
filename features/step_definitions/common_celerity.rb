Before do
  $rails_server ||= Culerity::run_rails
  sleep 5
  $server ||= Culerity::run_server
  $browser = Culerity::RemoteBrowserProxy.new $server, {:browser => :firefox}
  $browser.webclient.setJavaScriptEnabled(false)
  @host = 'http://localhost:3001'
end

Before("@js") do
  $browser.webclient.setJavaScriptEnabled(true)
end

at_exit do
  $browser.exit if $browser
  $server.exit_server if $server
  Process.kill(6, $rails_server.pid.to_i) if $rails_server
end

Given /^I am on (.+)$/ do |page_name|
  $browser.goto(@host + path_to(page_name))
  assert_successful_response
end

When "I wait for the ajax call to finish" do
  $browser.wait
end

When /I press "(.*)"/ do |button|
  $browser.button(:text, button).click
  assert_successful_response
end

When /I follow "(.*)"$/ do |link|
  $browser.link(:text, /#{link}/).click
  assert_successful_response
end

When /I follow "(.*)" and (do not)? ?confirm$/ do |link, do_not|
  $browser.confirm(do_not.blank?) do
    When %{I follow "#{link}"}
  end
end

When /I fill in "(.*)" for "(.*)"/ do |value, field|
  $browser.text_field(:id, find_label(field).for).set(value)
end

When /I fill in "(.*)" with "(.*)"/ do |field, value|
  $browser.text_field(:id, find_label(field).for).set(value)
end

When /I check "(.*)"/ do |field|
  $browser.check_box(:id, find_label(field).for).set(true)
end

When /^I uncheck "(.*)"$/ do |field|
  $browser.check_box(:id, find_label(field).for).set(false)
end

When /I select "(.*)" from "(.*)"/ do |value, field|
  $browser.select_list(:id, find_label(field).for).select value
end

When /I choose "(.*)"/ do |field|
  $browser.radio(:id, find_label(field).for).set(true)
end

When /I go to (.+)/ do |path|
  $browser.goto @host + path_to(path)
  assert_successful_response
end

When /I wait for the AJAX call to finish/ do
  $browser.wait
end

Then /I should see "(.*)"$/ do |text|
  # if we simply check for the browser.html content we don't find content that has been added dynamically, e.g. after an ajax call
  unless document_source =~ /#{text}/
    raise("'#{text}' not found")
  end
end

Then /show me (?:the) source/i do
  puts document_source
end

def document_source
  unless $browser.document.nil?
    $browser.document.asXml
  else
    $browser.html
  end
end

Then /I should not see "(.*)"$/ do |text|
  # if we simply check for the browser.html content we don't find content that has been added dynamically, e.g. after an ajax call
  if document_source =~ /#{text}/
    raise("'#{text}' found")
  end
end

def find_label(text)
  $browser.label :text, /#{text}/i
end

def assert_successful_response
  status = $browser.page.web_response.status_code
  if(status == 302 || status == 301)
    location = $browser.page.web_response.get_response_header_value('Location')
    puts "Being redirected to #{location}"
    $browser.goto location
    assert_successful_response
  elsif status != 200
    tmp = Tempfile.new 'culerity_results'
    tmp << $browser.html
    tmp.close
    `open -a /Applications/Safari.app #{tmp.path}`
    raise "Brower returned Response Code #{$browser.page.web_response.status_code}"
  end
end
