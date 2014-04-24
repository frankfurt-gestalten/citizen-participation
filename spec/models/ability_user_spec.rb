require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject { Ability.new(user) }

  describe 'regular user' do
    let(:user) { create(:user) }

    describe 'initiative' do
      let(:initiative) { create(:initiative, user: user) }

      it { should be_able_to :create, Initiative }
      it { should be_able_to :read, initiative }
      it { should be_able_to :edit, initiative }
      it { should be_able_to :support, initiative }
      it { should be_able_to :unsupport, initiative }
      it { should be_able_to :update, initiative }
      it { should_not be_able_to :destroy, initiative }

      context 'when user is blocked' do
        let(:user) { create(:user, role: 'blocked') }
        it { should_not be_able_to :create, Initiative }
      end
    end

    describe 'initiative of another user' do
      let(:initiative) { create(:initiative) }

      it { should be_able_to :read, initiative }
      it { should_not be_able_to :edit, initiative }
      it { should be_able_to :support, initiative }
      it { should be_able_to :unsupport, initiative }
      it { should_not be_able_to :update, initiative }
      it { should_not be_able_to :destroy, initiative }
    end

    describe 'comment' do
      let(:initiative) { create(:initiative) }
      let(:comment) { create(:comment, commentable: initiative, user: user) }

      it { should be_able_to :create, Comment }
      it { should be_able_to :read, comment }
      #it { should be_able_to :edit, comment }
      #it { should be_able_to :update, comment }
      it { should_not be_able_to :destroy, comment }

      context 'when user is blocked' do
        let(:user) { create(:user, role: 'blocked') }
        it { should_not be_able_to :create, Comment }
      end
    end

    describe 'comment of another user' do
      let(:initiative) { create(:initiative) }
      let(:comment) { create(:comment, commentable: initiative) }

      it { should be_able_to :read, comment }
      it { should_not be_able_to :edit, comment }
      it { should_not be_able_to :update, comment }
      it { should_not be_able_to :destroy, comment }
    end

    describe 'user' do
      it { should_not be_able_to :index, User }
      it { should_not be_able_to :destroy, user }
    end

    describe 'user of another user' do
      let(:another_user) { create(:user) }

      it { should be_able_to :show, another_user }
      it { should_not be_able_to :edit, another_user }
      it { should_not be_able_to :update, another_user }
      it { should_not be_able_to :destroy, another_user }
    end

    describe 'page' do
      let(:page) { create(:page) }

      it { should be_able_to :read, page }
      it { should_not be_able_to :edit, page }
      it { should_not be_able_to :update, page }
      it { should_not be_able_to :destroy, page }
    end
  end
end
