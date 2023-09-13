require 'rails_helper'

RSpec.describe Job, type: :model do
  it "has a valid factory" do
    job = FactoryBot.create(:job)
    expect(job).to be_valid
  end

  it "is invalid without a title" do
    job = FactoryBot.build(:job, title: nil)
    expect(job).to_not be_valid
  end

  it "is invalid without a description" do
    job = FactoryBot.build(:job, description: nil)
    expect(job).to_not be_valid
  end

  it "is invalid without a salary" do
    job = FactoryBot.build(:job, salary: nil)
    expect(job).to_not be_valid
  end

  it "returns a job's full details" do
    job = FactoryBot.create(:job, title: "Software Developer", description: "Ruby on Rails developer", salary: 80000)
    expect(job.full_details).to eq("Title: Software Developer, Description: Ruby on Rails developer, Salary: 80000")
  end

  # Add more tests related to your Job model as needed
end
