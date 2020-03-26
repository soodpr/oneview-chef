require_relative './../../../spec_helper'

describe 'oneview_test::hypervisor_cluster_profile_add_if_missing' do
  let(:resource_name) { 'hypervisor_cluster_profile' }
  include_context 'chef context'

  it 'storage system does not exist' do
    allow_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:exists?).and_return(false)
    expect_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:add).and_return(true)
    expect(real_chef_run).to add_oneview_hypervisor_cluster_profile_if_missing('HypervisorClusterProfile1')
  end

  it 'storage system already exists' do
    allow_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:exists?).and_return(true)
    allow_any_instance_of(OneviewSDK::HypervisorClusterProfile).to receive(:retrieve!).and_return(true)
    expect_any_instance_of(OneviewSDK::HypervisorClusterProfile).to_not receive(:add)
    expect(real_chef_run).to add_oneview_hypervisor_cluster_profile_if_missing('HypervisorClusterProfile1')
  end
end
