require_relative './../../../spec_helper'

describe 'oneview_test::hypervisor_cluster_profile_remove' do
  let(:resource_name) { 'hypervisor_cluster_profile' }
  include_context 'chef context'

  it 'removes it when it exists' do
    allow_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:retrieve!).and_return(true)
    expect_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:remove).and_return(true)
    expect(real_chef_run).to remove_oneview_hypervisor_cluster_profile('HypervisorClusterProfile1')
  end

  it 'does nothing when it does not exist' do
    allow_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:retrieve!).and_return(false)
    expect_any_instance_of(OneviewSDK::HypervisorClusterProfile).to_not receive(:remove)
    expect(real_chef_run).to remove_oneview_hypervisor_cluster_profile('HypervisorClusterProfile1')
  end
end
