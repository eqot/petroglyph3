require 'spec_helper'

describe VideoLike do

  let(:user) { FactoryGirl.create(:user) }
  let(:video) { FactoryGirl.create(:video) }
  let(:video_like) { user.video_likes.build(video_id: video.id) }

  subject { video_like }

  it { should be_valid }

  describe 'methods' do
    it { should respond_to(:user_id) }
    it { should respond_to(:video_id) }

    its(:user) { should eq user }
    its(:video) { should eq video }
  end

  describe 'when user id is not present' do
    before { video_like.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when video id is not present' do
    before { video_like.video_id = nil }
    it { should_not be_valid }
  end

end
