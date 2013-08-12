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
  subject { @tag }

  it { should respond_to :name }
  it { should respond_to :reviews }
  it { should respond_to :articles }

  describe "with default values" do
    it { should be_valid }
  end

  describe "Name" do

    describe "when name is too big" do
      before { @tag.name = 'abc' * 1000 }
      it { should_not be_valid}
    end

    describe "when name is too small" do
      before { @tag.name = 'a' }
      it { should_not be_valid }
    end

    describe "when name is blank" do
      before { @tag.name = ' ' }
      it { should_not be_valid }
    end

  end

end
