require 'spec_helper'

describe "Video pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "index" do
    # before { visit videos_path }

    # it { should have_title("All videos") }
    # it { should have_content("All videos") }

    describe "pagination" do

      # before(:all) { 30.times { FactoryGirl.create(:video, user: user) } }
      # after(:all) { Video.delete_all }

      # it { should have_selector("ul.pagination") }

    #   it "should list each video" do
    #     Video.paginate(page: 1).each do |video|
    #       expect(page).to have_selector("li", text: video.title)
    #     end
    #   end

    end
  end

  describe "creation" do
    before { visit new_video_path }

    describe "with invalid information" do
      it "should not create a video" do
        expect { click_button "Add video" }.not_to change(Video, :count)
      end

      describe "error message" do
        before { click_button "Add video" }
        it { should have_selector("div.field_with_errors") }
      end
    end

    describe "with valid information" do
      before { fill_in "Url", with: "http://www.youtube.com/" }
      it "should create a video" do
        # expect { click_button "Add video" }.to change(Video, :count).by(1)
      end
    end

  end

end
