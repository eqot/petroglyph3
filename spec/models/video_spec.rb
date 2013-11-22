require 'spec_helper'

describe Video do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @video = user.videos.build(url: "http://www.youtube.com/", title: "Title", description: "Description")
  end

  subject { @video }

  it { should respond_to(:url) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:contains) }
  it { should respond_to(:containers) }
  it { should respond_to(:video_likes) }
  it { should respond_to(:likes) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @video.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank url" do
    before { @video.url = " " }
    it { should_not be_valid }
  end

  describe "with a wrong url" do
    before { @video.url = "Lorem ipsum" }
    it { should_not be_valid }
  end

  describe "with a right url" do
    before { @video.url = "http://www.youtube.com/" }
    it { should be_valid }
  end

end
