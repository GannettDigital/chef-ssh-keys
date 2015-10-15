require_relative '../spec_helper'

describe 'ssh-keys::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['ssh_keys'] = { root: ["test"] }
      stub_data_bag_item('users', 'test').and_return({id: "test", ssh_keys: "test_key"})
    end.converge(described_recipe)
  end

  it 'creates a directory with attributes' do
    expect(chef_run).to create_directory('/home/root/.ssh').with(
      mode:   0700,
      owner: 'root',
      group: 'root'
    )
  end

  it 'creates a template authorized_keys' do
    expect(chef_run).to create_template('/home/root/.ssh/authorized_keys').with(
      source: 'authorized_keys.erb',
      mode:   0600,
      owner: 'root',
      group: 'root',
      action: [:create]
    )
  end 
 end
