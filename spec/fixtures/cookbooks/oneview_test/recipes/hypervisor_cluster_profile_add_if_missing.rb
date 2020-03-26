#
# Cookbook Name:: oneview_test
# Recipe:: hypervisor_cluster_profile_add_if_missing
#
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

oneview_hypervisor_cluster_profile 'TestHypervisorClusterProfile' do
  client node['oneview_test']['client800']
  data(
    credentials: {
      type: 'HypervisorClusterProfileV3',
      name: 'Cluster5',
      hypervisorManagerUri: '/rest/hypervisor-managers/befc6bd9-0366-4fd9-a3fc-c92ab0df3603',
      path: 'DC2',
      hypervisorType: 'HypervisorClusterProfileV3',
      hypervisorHostProfileTemplate: {
        serverProfileTemplateUri: '/rest/server-profile-templates/c865a62c-8fd8-414c-8c16-3f7ca75ab2ba',
        deploymentPlan: {
          deploymentPlanUri: '/rest/os-deployment-plans/c54e1dab-cc14-48fa-92bf-d301671fb0cf',
          serverPassword: 'dcs'
        },
        hostprefix: 'Test-Cluster-host'
      }
    }
  )
  action :add_if_missing
end
