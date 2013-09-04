require 'spec_helper'

describe "Authentication" do
  before { visit signin_path }
  subject { page }

  describe "signin page" do
    it { should have_title(full_title('Sign In')) }
    it { should have_content('Sign In') }
  end

  describe "signin" do
    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_title(full_title('Sign In')) }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting with another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(full_title(user.name)) }
      it { should have_link('Profile') }
      it { should have_link('Sign out')}
      it { should_not have_link('Sign in') }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in')}
      end
    end
  end
end
