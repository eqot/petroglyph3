require 'spec_helper'

describe Playlist do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @playlist = user.playlists.build(title: "Playlist Title", description: "Description")
  end

  subject { @playlist }

  it { should respond_to(:contains) }
  it { should respond_to(:contained_videos) }
  its(:user) { should eq user }

  it { should respond_to(:containing?) }
  it { should respond_to(:add!) }

  describe "adding" do
    let(:other_video) { FactoryGirl.create(:video) }
    before do
      @playlist.save
      @playlist.add!(other_video, 0)
    end

    it { should be_containing(other_video) }
    # its(:contained_videos) { should include(other_video) }

    describe "and removing" do
      before { @playlist.remove!(other_video) }

      it { should_not be_containing(other_video) }
      # its(:contained_videos) { should_not include(other_video) }
    end
  end

end
