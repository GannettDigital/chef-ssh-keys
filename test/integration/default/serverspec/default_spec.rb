require_relative 'spec_helper'

describe 'ssh-keys' do
  describe file('/root/.ssh/authorized_keys') do
    it { should contain 'test_key' }
  end
end
