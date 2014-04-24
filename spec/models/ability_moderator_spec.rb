require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject { Ability.new(user) }

  describe 'superadmin' do
    let(:user) { create(:user, role: 'superadmin') }

    it { should be_able_to :manage, :all }
  end

  describe 'moderator' do
    let(:account) { create(:account) }
    let(:another_account) { create(:account) }
    let(:user) { account.users.first }

    describe 'account' do
      it { should be_able_to :add_idea, account }
      it { should be_able_to :add_news, account }
      it { should be_able_to :add_page, account }
      it { should be_able_to :show, account }
      it { should be_able_to :update, account }
      it { should be_able_to :edit, account }
      it { should be_able_to :destroy, account }
      it { should_not be_able_to :index, Account }
      it { should be_able_to :list_content, account }
      it { should be_able_to :list_participants, account }
      it { should_not be_able_to :assign_moderator, account }
      it { should_not be_able_to :remove_moderator, account }
    end

    describe 'another account', :multitenant do
      it { should_not be_able_to :add_idea, another_account }
      it { should_not be_able_to :add_news, another_account }
      it { should_not be_able_to :add_page, another_account }
      it { should_not be_able_to :show, another_account }
      it { should_not be_able_to :update, another_account }
      it { should_not be_able_to :edit, another_account }
      it { should_not be_able_to :destroy, another_account }
      it { should_not be_able_to :list_content, another_account }
      it { should_not be_able_to :list_participants, another_account }
      it { should_not be_able_to :assign_moderator, another_account }
      it { should_not be_able_to :remove_moderator, another_account }
    end

    describe 'idea' do
      let(:idea) { create(:idea, account: account) }

      it { should be_able_to :create, Idea }
      it { should be_able_to :read, idea }
      it { should be_able_to :edit, idea }
      it { should be_able_to :vote, idea }
      it { should be_able_to :update, idea }
      it { should be_able_to :destroy, idea }
      it { should be_able_to :comment, idea }
      it { should be_able_to :update_subscription, idea }
    end

    describe 'idea from another account', :multitenant do
      let(:idea) { create(:idea, account: another_account) }

      it { should_not be_able_to :read, idea }
      it { should_not be_able_to :edit, idea }
      it { should_not be_able_to :vote, idea }
      it { should_not be_able_to :update, idea }
      it { should_not be_able_to :destroy, idea }
      it { should_not be_able_to :comment, idea }
      it { should_not be_able_to :update_subscription, idea }
    end

    describe 'comment' do
      let(:idea) { create(:idea, account: account) }
      let(:comment) { create(:comment, account: account, commentable: idea) }

      it { should be_able_to :create, Comment }
      it { should be_able_to :read, comment }
      it { should be_able_to :edit, comment }
      it { should be_able_to :update, comment }
      it { should be_able_to :destroy, comment }
    end

    describe 'comment from another account', :multitenant do
      let(:idea) { create(:idea, account: another_account) }
      let(:comment) { create(:comment, account: another_account, commentable: idea) }

      it { should_not be_able_to :read, comment }
      it { should_not be_able_to :edit, comment }
      it { should_not be_able_to :update, comment }
      it { should_not be_able_to :destroy, comment }
    end

    describe 'news' do
      let(:news) { create(:news, account: account) }

      it { should be_able_to :create, News }
      it { should be_able_to :read, news }
      it { should be_able_to :edit, news }
      it { should be_able_to :update, news }
      it { should be_able_to :destroy, news }
      it { should be_able_to :comment, news }
    end

    describe 'news from another account', :multitenant do
      let(:news) { create(:news, account: another_account) }

      it { should_not be_able_to :read, news }
      it { should_not be_able_to :edit, news }
      it { should_not be_able_to :update, news }
      it { should_not be_able_to :destroy, news }
      it { should_not be_able_to :comment, news }
    end

    describe 'voting' do
      let(:idea) { create(:idea, account: account) }
      let(:voting) { Voting.create!(idea: idea, user: user) }
      let(:another_voting) { Voting.create!(idea: idea, user: idea.user) }

      it { should be_able_to :create, Voting }
      it { should be_able_to :update, voting }
      it { should_not be_able_to :update, another_voting }
    end

    describe 'voting for another account', :multitenant do
      let(:idea) { create(:idea, account: another_account) }
      let(:another_voting) { Voting.create!(idea: idea, user: idea.user) }

      it { should_not be_able_to :update, another_voting }
    end

    describe 'profile' do
      let(:profile) { user.profile }

      it { should be_able_to :show, profile }
      it { should be_able_to :edit, profile }
      it { should be_able_to :update, profile }
      it { should_not be_able_to :destroy, profile }
    end

    describe 'profile of another user' do
      let(:another_user) { create(:user) }
      let(:profile) { another_user.profile }

      before do
        account.users << another_user
      end

      it { should be_able_to :show, profile }
      it { should_not be_able_to :edit, profile }
      it { should_not be_able_to :update, profile }
      it { should_not be_able_to :destroy, profile }
    end

    describe 'profile of another user in another account', :multitenant do
      let(:another_user) { another_account.users.first }
      let(:profile) { another_user.profile }

      it { should_not be_able_to :show, profile }
    end

    describe 'page' do
      let(:page) { create(:page, account: account) }

      it { should be_able_to :create, page }
      it { should be_able_to :read, page }
      it { should be_able_to :edit, page }
      it { should be_able_to :update, page }
      it { should be_able_to :destroy, page }
    end

    describe 'page of another account', :multitenant do
      let(:page) { create(:page, account: another_account) }

      it { should_not be_able_to :read, page }
      it { should_not be_able_to :edit, page }
      it { should_not be_able_to :update, page }
      it { should_not be_able_to :destroy, page }
    end
  end
end
