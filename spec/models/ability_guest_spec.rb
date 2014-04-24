require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject { Ability.new(user) }

  describe 'guest' do
    let(:user) { nil }

    describe 'initiative' do
      let(:initiative) { create(:initiative) }

      it { should be_able_to :read, initiative }
      it { should_not be_able_to :edit, initiative }
      it { should_not be_able_to :vote, initiative }
      it { should_not be_able_to :update, initiative }
      it { should_not be_able_to :destroy, initiative }
      it { should be_able_to :create, Comment }
    end

    describe 'antraege' do
      let(:antraege) { create(:antraege) }

      it { should be_able_to :read, antraege }
      it { should_not be_able_to :edit, antraege }
      it { should_not be_able_to :vote, antraege }
      it { should_not be_able_to :update, antraege }
      it { should_not be_able_to :destroy, antraege }
      it { should be_able_to :create, Comment }
    end

    describe 'comment' do
      let(:initiative) { create(:initiative) }
      let(:comment) { create(:comment, commentable: initiative) }

      it { should be_able_to :read, comment }
      it { should_not be_able_to :edit, comment }
      it { should_not be_able_to :update, comment }
      it { should_not be_able_to :destroy, comment }
    end

    pending 'voting' do
      let(:idea) { create(:idea) }
      let(:voting) { Voting.create!(idea: idea, user: idea.user) }

      it { should_not be_able_to :update, voting }
    end

    pending 'profile' do
      let(:profile) { users.first.profile }

      it { should_not be_able_to :show, profile }
      it { should_not be_able_to :edit, profile }
      it { should_not be_able_to :update, profile }
      it { should_not be_able_to :destroy, profile }
    end

    pending 'pages' do
      let(:page) { create(:page) }

      it { should be_able_to :show, page }
      it { should_not be_able_to :edit, page }
      it { should_not be_able_to :update, page }
      it { should_not be_able_to :destroy, page }
    end
  end
end
