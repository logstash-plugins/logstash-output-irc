# encoding: utf-8
require_relative "../spec_helper"
require "cinch"

describe LogStash::Outputs::Irc do

  let(:host) { "localhost" }
  let(:port) { rand(2048)+1024 }

  let(:channels) { ["#logstash", "#elastic"] }

  it "should register without errors" do
    plugin = LogStash::Plugin.lookup("output", "irc").new("host" => host, "port" => port, "channels" => channels)
    expect { plugin.register }.to_not raise_error
  end

  describe "#send" do

    subject { LogStash::Outputs::Irc.new("host" => host, "port" => port, "channels" => channels ) }

    let(:properties) { { "message" => "This is a message!"} }
    let(:event)      { LogStash::Event.new(properties) }
    let(:channel)    { double("channel") }

    let(:bot)     { Cinch::Bot.new }

    before(:each) do
      allow(channel).to receive(:msg)
      subject.inject_bot(bot).register
      expect(subject.bot).to receive(:channels).and_return([channel])
    end

    it "sends the generated event to the irc" do
      expect(channel).to receive(:msg).with("This is a message!")
      subject.receive(event)
    end

  end
end
