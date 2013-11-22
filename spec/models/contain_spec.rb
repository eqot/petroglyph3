require 'spec_helper'

describe Contain do

  let(:playlist) { FactoryGirl.create(:playlist) }
  let(:video) { FactoryGirl.create(:video) }
  let(:contain) { playlist.contains.build(video_id: video.id) }

  subject { contain }

  it { should be_valid }

  describe "methods" do
    it { should respond_to(:playlist) }
    it { should respond_to(:video) }

    its(:playlist) { should eq playlist }
    its(:video) { should eq video }
  end

  describe "when playlist id is not present" do
    before { contain.playlist_id = nil }
    it { should_not be_valid }
  end

  describe "when video id is not present" do
    before { contain.video_id = nil }
    it { should_not be_valid }
  end

end
