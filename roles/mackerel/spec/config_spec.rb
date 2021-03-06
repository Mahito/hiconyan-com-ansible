require 'spec_helper'

describe file('/etc/mackerel-agent/conf.d') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/mackerel-agent/mackerel-agent.conf') do
  it { should be_file }
  it { should contain "apikey = \"#{property['mackerel_apikey']}\"" }
  it { should contain "display_name = \"#{property['mackerel_display_name']}\"" }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

property['mackerel_plugins'].each do |item|
  describe file("/etc/mackerel-agent/conf.d/#{item}.conf") do
    it { should be_file }
    it { should contain "[plugin.metrics.#{item}]" }
    it { should contain "/usr/local/bin/mackerel-plugin-#{item}" }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

describe file('/etc/mackerel-agent/conf.d/redis.conf') do
  it { should contain "-password #{property['redis_password']}" }
end
