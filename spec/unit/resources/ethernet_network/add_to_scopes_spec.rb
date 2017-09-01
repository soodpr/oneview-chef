require_relative './../../../spec_helper'

describe 'oneview_test_api300_synergy::ethernet_network_add_to_scopes' do
  let(:resource_name) { 'ethernet_network' }
  include_context 'chef context'

  let(:scope1) { OneviewSDK::API300::Synergy::Scope.new(client, name: 'Scope1', uri: '/rest/fake/1') }
  let(:scope2) { OneviewSDK::API300::Synergy::Scope.new(client, name: 'Scope2', uri: '/rest/fake/2') }

  before do
    allow(OneviewSDK::API300::Synergy::Scope).to receive(:new).and_return(scope1, scope2)
    allow(scope1).to receive(:retrieve!).and_return(true)
    allow(scope2).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:[]).and_call_original
  end

  it 'adds all scopes when are not added' do
    allow_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:[]).with('scopeUris').and_return([])
    expect_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:add_scope).with(scope1)
    expect_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:add_scope).with(scope2)
    expect(real_chef_run).to add_oneview_ethernet_network_to_scopes('EthernetNetwork1')
  end

  it 'adds only the scope that is not added' do
    allow_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:[]).with('scopeUris').and_return(['/rest/fake/1'])
    expect_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).not_to receive(:add_scope).with(scope1)
    expect_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:add_scope).with(scope2)
    expect(real_chef_run).to add_oneview_ethernet_network_to_scopes('EthernetNetwork1')
  end

  it 'does nothing when scopes are already added' do
    allow_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).to receive(:[]).with('scopeUris').and_return(['/rest/fake/1', '/rest/fake/2'])
    expect_any_instance_of(OneviewSDK::API300::Synergy::EthernetNetwork).not_to receive(:add_scope)
    expect(real_chef_run).to add_oneview_ethernet_network_to_scopes('EthernetNetwork1')
  end
end
