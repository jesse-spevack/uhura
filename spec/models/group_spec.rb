require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:enrollments) }
  it { should have_many(:students) }

  it "knows the names of all of its students" do
    group = FactoryGirl.create(:group)
    students = FactoryGirl.create_list(:student, 2)
    students.each do |student|
      FactoryGirl.create(:enrollment, student: student, group: group)
    end

    expected = students.map { |student| student.name }

    expect(group.names).to eq(expected)
  end

  it "knows total number of messages sent to students" do
    user = FactoryGirl.create(:user)
    group = FactoryGirl.create(:group)
    students = FactoryGirl.create_list(:student, 2)
    students.each do |student|
      FactoryGirl.create(:enrollment, student: student, group: group)
      contact = FactoryGirl.create(:contact, contactable: student)
      FactoryGirl.create(:message, contact: contact, user: user)
    end

    expect(group.student_message_count).to eq(2)
  end

  xit "knows total number of messages sent to guardians" do
    user = FactoryGirl.create(:user)
    group = FactoryGirl.create(:group)
    students = FactoryGirl.create_list(:student, 2)
    students.each do |student|
      FactoryGirl.create(:enrollment, student: student, group: group)
      guardian = FactoryGirl.create(:guardian)
      FactoryGirl.create(:guardianship, student: student, guardian: guardian)
      contact = FactoryGirl.create(:contact, contactable: guardian)
      FactoryGirl.create(:message, contact: contact, user: user)
    end

    expect(group.guardian_message_count).to eq(2)
  end
end
