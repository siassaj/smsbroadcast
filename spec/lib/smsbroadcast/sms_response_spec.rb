require 'spec_helper'

describe Smsbroadcast::SmsResponse do

  let(:ok_response)    { "OK:61411111111:2942263" }
  let(:bad_response)   { "BAD:61411111111:problem message" }
  let(:error_response) { "ERROR:A reason for error"}

  describe "::new" do
    it "parses an ok response" do
      subject = described_class.new ok_response
      expect(subject.status).to eq :ok
      expect(subject.number).to eq "61411111111"
      expect(subject.ref).to eq "2942263"
    end

    it "parses a bad response" do
      subject = described_class.new bad_response
      expect(subject.status).to eq :bad
      expect(subject.number).to eq "61411111111"
      expect(subject.message).to eq "problem message"
    end

    it "parses an error response" do
      subject = described_class.new error_response
      expect(subject.status).to eq :error
      expect(subject.message).to eq "A reason for error"
    end
  end
end
