require 'spec_helper'

describe Post do
  describe "#creating posts that includes gists" do
    
    context 'check that gist tag is parsed properly' do
      let(:post) { Factory(:post_with_gist) }
      it { Posts::ShowPresenter.new(post).body.include?(Github::Gist.script_tag(777)).should == true }
    end
    
    context 'should replace usernames in posts' do
      let(:user) { Factory(:user) }
      let(:post) { Factory(:post, :body => " @#{user.username} #{Faker::Lorem.paragraph}") }
      it { puts Posts::ShowPresenter.new(post).body }
    end
  end
end
