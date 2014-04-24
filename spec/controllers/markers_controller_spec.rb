require 'spec_helper'

describe MarkersController do
  describe 'GET index' do
    before do
      3.times { create :initiative }
      2.times { create :antraege }
      1.times { create :construction }
    end

    it 'defines all types of markers by default' do
      get :index
      assigns(:initiatives).should_not   be_nil
      assigns(:antraeges).should_not     be_nil
      assigns(:constructions).should_not be_nil
    end

    it 'does search markers according what is in params[:types]' do
      get :index, :format => :json, :types => ['construction']
      assigns(:initiatives).should       be_nil
      assigns(:antraeges).should         be_nil
      assigns(:constructions).should_not be_nil

      parsed = JSON.parse response.body

      parsed.should be_a Hash
      parsed.keys.should == [
        "initiatives", "antraeges", "constructions", "location", "zoom"
      ]
      parsed['initiatives'].should   == []
      parsed['antraeges'].should     == []
      # Search not being tested yet
      parsed['constructions'].should == []
    end
  end
end
