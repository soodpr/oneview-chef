# (c) Copyright 2020 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

my_client = {
  url: ENV['ONEVIEWSDK_URL'],
  user: ENV['ONEVIEWSDK_USER'],
  password: ENV['ONEVIEWSDK_PASSWORD'],
  api_version: 800
}

hypervisor_credentials = {
  type: @hypervisor_type,
  name: @hypervisor_cluster_profile_name,
  hypervisorManagerUri: @hypervisor_manager_uri,
  path: @hypervisor_path,
  hypervisorType: @hypervisor_hypervisorType,
  hypervisorHostProfileTemplate: {
  serverProfileTemplateUri: @hypervisor_serverProfileTemplateUri,
  deploymentPlan: {
      deploymentPlanUri: @hypervisor_deploymentPlanUri,
      serverPassword: @hypervisor_server_password
    },
      hostprefix: @hypervisor_host_prefix
  }
}

# Example: add hypervisor cluster profile or update if it already exists
oneview_hypervisor_cluster_profile 'HypervisorClusterProfile1' do
  client my_client
  data(
    hypervisor_credentials
  )
  action :add
end

# Example: add hypervisor cluster profile if it does not exist
oneview_hypervisor_cluster_profile 'HypervisorClusterProfile1' do
    client my_client
    data(
        hypervisor_credentials
    )
    action :add_if_missing
  end

# Example: remove hypervisor cluster profile
oneview_hypervisor_cluster_profile 'HypervisorClusterProfile1' do
  client my_client
  action :remove
end
