require 'spec_helper'

describe group('docker') do
  it { should exist }
end

describe user(ENV['TARGET_USER']) do
  it { should belong_to_group 'docker' }
end
