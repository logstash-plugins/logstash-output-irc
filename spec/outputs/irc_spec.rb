# encoding: utf-8
require_relative "../spec_helper"

describe LogStash::Outputs::Irc do

  let(:host) { "localhost" }
  let(:port) { rand(2048)+1024 }

  let(:channels) { ["logstash"] }
  it "should register without errors" do
    plugin = LogStash::Plugin.lookup("output", "irc").new("host" => host, "port" => port, "channels" => channels)
    expect { plugin.register }.to_not raise_error
  end

end
