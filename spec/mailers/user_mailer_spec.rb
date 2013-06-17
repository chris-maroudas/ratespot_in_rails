require "spec_helper"

describe UserMailer do
  describe "registered_user" do
    let(:mail) { UserMailer.registered_user }

    it "renders the headers" do
      mail.subject.should eq("Registered user")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
