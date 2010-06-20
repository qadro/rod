require 'fred'
require 'test/unit/assertions'
World(Test::Unit::Assertions)

Before do
  $freds = {}
end

Given /database is opened for writing/ do
  Rod::Model.close_database if Rod::Model.opened?
  File.delete("tmp/fred.dat")
  Rod::Model.create_database('tmp/fred.dat')
end

Given /^Fred is (\d+) years old/ do |age_str|
  $f = RodScenario::Fred.new
  $f.age = Integer(age_str)
end

When /^I store Fred$/ do
  $f.store
  $id = $f.rod_id
end

When /^I reopen database for reading$/ do
  Rod::Model.close_database
  Rod::Model.open_database('tmp/fred.dat')
end

When /^I restore Fred$/ do
  $f = RodScenario::Fred.find_by_rod_id($id)
end

Then /^database should be opened for reading$/ do
  assert Rod::Model.opened?
  assert Rod::Model.readonly_data?
end

Then /^Fred should be (\d+) years old/ do |expected_age|
  assert_equal Integer(expected_age), $f.age
end

Given /^(\w+) Fred is (\w+)$/ do |name, sex|
  $freds[name] = sex
end

When /^I store all Freds$/ do
  $freds.each do |name, sex|
    f = RodScenario::Fred.new
    f.age = 18
    f.sex = sex
    f.store
  end
end

Then /^database should contain (\d+) (\w+) Freds$/ do |expected_count, sex|
  assert_equal Integer(expected_count), RodScenario::Fred.find_all_by_sex(sex).count
end
