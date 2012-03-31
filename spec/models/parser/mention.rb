require 'spec_helper'

describe Parser::Mention do
  describe "parsing comments body" do
    
    context 'should give usernames if content contains @username' do
      let(:user_1) { FactoryGirl.create(:user) }
      let(:user_2) { FactoryGirl.create(:user) }
      let(:user_3) { FactoryGirl.create(:user) }
      let(:user_4) { FactoryGirl.create(:user) }
      body = "@#{user_1.username} @#{user_2.username},#{Faker::Lorem.paragraph} @#{user_3.username}! gmail@#{user_4.username}.com"
      it {Parser::Mention.new(body).usernames.should == ["user_1", "user_2", "user_3"]}
    end
    
    context 'if comment doesnt has a mention usernames should be an empty array' do
      comment = FactoryGirl.create(:comment)
      it {Parser::Mention.new(comment.body).usernames.should == []}
    end
    
    context 'should not parse emails' do
      comment = FactoryGirl.create(:comment)
      it {Parser::Mention.new(comment.body).usernames.should == []}
    end
  end
  
end
