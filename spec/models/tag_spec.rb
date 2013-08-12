# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Tag do

  before { @tag = Tag.new(name: 'asus') }

  it { should respond_to :name }
  it { should respond_to :reviews }
  it { should respond_to :articles }

  describe "Name" do

    describe "when name is too big" do
      before { @tag.name = 'abc' * 1000 }
      it { should_not be_valid}
    end


  end
  
end
