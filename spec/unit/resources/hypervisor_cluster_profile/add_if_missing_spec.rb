require_relative './../../../spec_helper'

describe 'oneview_test::hypervisor_cluster_profile_add_if_missing' do
  let(:resource_name) { 'hypervisor_cluster_profile' }
  let(:base_sdk) { OneviewSDK::API800::C7000 }
  include_context 'chef context'

  it 'hypervisor cluster profile does not exist' do
    allow_any_instance_of(base_sdk::HypervisorClusterProfile).to receive(:exists?).and_return(false)
    expect_any_instance_of(base_sdk::HypervisorClusterProfile).to receive(:add).and_return(true)
    expect(real_chef_run).to add_oneview_hypervisor_cluster_profile_if_missing('HypervisorClusterProfile1')
  end

  it 'hypervisor cluster profile already exists' do
    allow_any_instance_of(base_sdk::HypervisorClusterProfile).to receive(:exists?).and_return(true)
    allow_any_instance_of(base_sdk::HypervisorClusterProfile).to receive(:retrieve!).and_return(true)
    expect_any_instance_of(base_sdk::HypervisorClusterProfile).to_not receive(:add)
    expect(real_chef_run).to add_oneview_hypervisor_cluster_profile_if_missing('HypervisorClusterProfile1')
  end
end
