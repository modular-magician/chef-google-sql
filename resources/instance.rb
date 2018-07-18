# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# Add our google/ lib
$LOAD_PATH.unshift ::File.expand_path('../libraries', ::File.dirname(__FILE__))

require 'chef/resource'
require 'google/hash_utils'
require 'google/sql/network/delete'
require 'google/sql/network/get'
require 'google/sql/network/post'
require 'google/sql/network/put'
require 'google/sql/property/boolean'
require 'google/sql/property/instance_authorized_networks'
require 'google/sql/property/instance_backend_type'
require 'google/sql/property/instance_database_version'
require 'google/sql/property/instance_failover_replica'
require 'google/sql/property/instance_instance_type'
require 'google/sql/property/instance_ip_addresses'
require 'google/sql/property/instance_ip_configuration'
require 'google/sql/property/instance_mysql_replica_configuration'
require 'google/sql/property/instance_replica_configuration'
require 'google/sql/property/instance_settings'
require 'google/sql/property/instance_type'
require 'google/sql/property/integer'
require 'google/sql/property/string'
require 'google/sql/property/string_array'
require 'google/sql/property/time'

module Google
  module GSQL
    # A provider to manage Google Cloud SQL resources.
    # rubocop:disable Metrics/ClassLength
    class Instance < Chef::Resource
      resource_name :gsql_instance

      property :backend_type,
               equal_to: %w[FIRST_GEN SECOND_GEN EXTERNAL],
               coerce: ::Google::Sql::Property::BackendTypeEnum.coerce, desired_state: true
      property :connection_name
               String, coerce: ::Google::Sql::Property::String.coerce, desired_state: true
      property :database_version,
               equal_to: %w[MYSQL_5_5 MYSQL_5_6 MYSQL_5_7 POSTGRES_9_6],
               coerce: ::Google::Sql::Property::DatabaseVersionEnum.coerce, desired_state: true
      property :failover_replica,
               [Hash, ::Google::Sql::Data::InstancFailoveReplica],
               coerce: ::Google::Sql::Property::InstancFailoveReplica.coerce, desired_state: true
      property :instance_type,
               equal_to: %w[CLOUD_SQL_INSTANCE ON_PREMISES_INSTANCE READ_REPLICA_INSTANCE],
               coerce: ::Google::Sql::Property::InstanceTypeEnum.coerce, desired_state: true
      # ip_addresses is Array of Google::Sql::Property::InstancIpAddressArray
      property :ip_addresses,
               Array,
               coerce: ::Google::Sql::Property::InstancIpAddressArray.coerce, desired_state: true
      property :ipv6_address
               String, coerce: ::Google::Sql::Property::String.coerce, desired_state: true
      property :master_instance_name
               String, coerce: ::Google::Sql::Property::String.coerce, desired_state: true
      property :max_disk_size
               Integer, coerce: ::Google::Sql::Property::Integer.coerce, desired_state: true
      property :i_label,
               String,
               coerce: ::Google::Sql::Property::String.coerce,
               name_property: true, desired_state: true
      property :region, String, coerce: ::Google::Sql::Property::String.coerce, desired_state: true
      property :replica_configuration,
               [Hash, ::Google::Sql::Data::InstancReplicaConfigu],
               coerce: ::Google::Sql::Property::InstancReplicaConfigu.coerce, desired_state: true
      property :settings,
               [Hash, ::Google::Sql::Data::InstanceSettings],
               coerce: ::Google::Sql::Property::InstanceSettings.coerce, desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'sql#instance')
        if fetch.nil?
          converge_by "Creating gsql_instance[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Sql::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            wait_for_operation create_req.send, @new_resource
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.backend_type =
            ::Google::Sql::Property::BackendTypeEnum.api_parse(fetch['backendType'])
          @current_resource.connection_name =
            ::Google::Sql::Property::String.api_parse(fetch['connectionName'])
          @current_resource.database_version =
            ::Google::Sql::Property::DatabaseVersionEnum.api_parse(fetch['databaseVersion'])
          @current_resource.failover_replica =
            ::Google::Sql::Property::InstancFailoveReplica.api_parse(fetch['failoverReplica'])
          @current_resource.instance_type =
            ::Google::Sql::Property::InstanceTypeEnum.api_parse(fetch['instanceType'])
          @current_resource.ip_addresses =
            ::Google::Sql::Property::InstancIpAddressArray.api_parse(fetch['ipAddresses'])
          @current_resource.ipv6_address =
            ::Google::Sql::Property::String.api_parse(fetch['ipv6Address'])
          @current_resource.master_instance_name =
            ::Google::Sql::Property::String.api_parse(fetch['masterInstanceName'])
          @current_resource.max_disk_size =
            ::Google::Sql::Property::Integer.api_parse(fetch['maxDiskSize'])
          @current_resource.i_label = ::Google::Sql::Property::String.api_parse(fetch['name'])
          @current_resource.region = ::Google::Sql::Property::String.api_parse(fetch['region'])
          @current_resource.replica_configuration =
            ::Google::Sql::Property::InstancReplicaConfigu.api_parse(
              fetch['replicaConfiguration']
            )
          @current_resource.settings =
            ::Google::Sql::Property::InstanceSettings.api_parse(fetch['settings'])

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource),
                               'sql#instance')
        unless fetch.nil?
          converge_by "Deleting gsql_instance[#{new_resource.name}]" do
            delete_req = ::Google::Sql::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            wait_for_operation delete_req.send, @new_resource
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      def exports
        {
          name: i_label
        }
      end

      private

      action_class do
        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength
        def resource_to_request
          request = {
            kind: 'sql#instance',
            backendType: new_resource.backend_type,
            connectionName: new_resource.connection_name,
            databaseVersion: new_resource.database_version,
            failoverReplica: new_resource.failover_replica,
            instanceType: new_resource.instance_type,
            ipv6Address: new_resource.ipv6_address,
            masterInstanceName: new_resource.master_instance_name,
            maxDiskSize: new_resource.max_disk_size,
            name: new_resource.i_label,
            region: new_resource.region,
            replicaConfiguration: new_resource.replica_configuration,
            settings: new_resource.settings
          }.reject { |_, v| v.nil? }
          unless @__fetched.nil?
            # Convert to pure JSON
            request = JSON.parse(request.to_json)
            request['settings']['settingsVersion'] =
              @__fetched['settings']['settingsVersion']
          end

          request.to_json
        end
        # rubocop:enable Metrics/MethodLength
        # rubocop:enable Metrics/AbcSize

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            update_req =
              ::Google::Sql::Network::Put.new(self_link(@new_resource),
                                              fetch_auth(@new_resource),
                                              'application/json',
                                              resource_to_request)
            wait_for_operation update_req.send, @new_resource
          end
        end

        # rubocop:disable Metrics/MethodLength
        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.i_label,
            kind: 'sql#instance',
            backend_type: resource.backend_type,
            connection_name: resource.connection_name,
            database_version: resource.database_version,
            failover_replica: resource.failover_replica,
            instance_type: resource.instance_type,
            ip_addresses: resource.ip_addresses,
            ipv6_address: resource.ipv6_address,
            master_instance_name: resource.master_instance_name,
            max_disk_size: resource.max_disk_size,
            region: resource.region,
            replica_configuration: resource.replica_configuration,
            settings: resource.settings
          }.reject { |_, v| v.nil? }
        end
        # rubocop:enable Metrics/MethodLength

        # Copied from Chef > Provider > #converge_if_changed
        def compute_changes
          properties = @new_resource.class.state_properties.map(&:name)
          properties = properties.map(&:to_sym)
          if current_resource
            compute_changes_for_existing_resource properties
          else
            compute_changes_for_new_resource properties
          end
        end

        # Collect the list of modified properties
        def compute_changes_for_existing_resource(properties)
          specified_properties = properties.select do |property|
            @new_resource.property_is_set?(property)
          end
          modified = specified_properties.reject do |p|
            @new_resource.send(p) == current_resource.send(p)
          end

          generate_pretty_green_text(modified)
        end

        def generate_pretty_green_text(modified)
          property_size = modified.map(&:size).max
          modified.map! do |p|
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               [
                                 @new_resource.send(p).inspect,
                                 "(was #{current_resource.send(p).inspect})"
                               ].join(' ')
                             end
            "  set #{p.to_s.ljust(property_size)} to #{properties_str}"
          end
        end

        # Write down any properties we are setting.
        def compute_changes_for_new_resource(properties)
          property_size = properties.map(&:size).max
          properties.map do |property|
            default = ' (default value)' \
              unless @new_resource.property_is_set?(property)
            next if @new_resource.send(property).nil?
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               @new_resource.send(property).inspect
                             end
            ["  set #{property.to_s.ljust(property_size)}",
             "to #{properties_str}#{default}"].join(' ')
          end.compact
        end

        def fetch_auth(resource)
          self.class.fetch_auth(resource)
        end

        def self.fetch_auth(resource)
          resource.resources("gauth_credential[#{resource.credential}]")
                  .authorization
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def debug(message)
          Chef::Log.debug(message)
        end

        def self.collection(data)
          URI.join(
            'https://www.googleapis.com/sql/v1beta4/',
            expand_variables(
              'projects/{{project}}/instances',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://www.googleapis.com/sql/v1beta4/',
            expand_variables(
              'projects/{{project}}/instances/{{name}}',
              data
            )
          )
        end

        def self_link(data)
          self.class.self_link(data)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def self.return_if_object(response, kind)
          raise "Bad response: #{response}" \
            unless response.is_a?(Net::HTTPResponse)
          return if response.is_a?(Net::HTTPNotFound)
          return if response.is_a?(Net::HTTPNoContent)
          # TODO(nelsonjr): Remove return of Net::HTTPForbidden from
          # return_if_object once Cloud SQL bug http://b/62635365 is resolved.
          # Currently the API returns 403 for objects that do not exist, even
          # when the user has access to the project. This is being changed to
          # return 404 as it is supposed to be.
          # Once 404 is the correct response, the temporary workaround should
          # be removed.
          return if response.is_a?(Net::HTTPForbidden)
          result = JSON.parse(response.body)
          raise_if_errors result, %w[error errors], 'message'
          raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
          raise "Incorrect result: #{result['kind']} (expecting #{kind})" \
            unless result['kind'] == kind
          result
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        def return_if_object(response, kind)
          self.class.return_if_object(response, kind)
        end

        def self.extract_variables(template)
          template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
                  .map(&:to_sym)
        end

        def self.expand_variables(template, var_data, extra_data = {})
          data = if var_data.class <= Hash
                   var_data.merge(extra_data)
                 else
                   resource_to_hash(var_data).merge(extra_data)
                 end
          extract_variables(template).each do |v|
            unless data.key?(v)
              raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
            end
            template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
          end
          template
        end

        def expand_variables(template, var_data, extra_data = {})
          self.class.expand_variables(template, var_data, extra_data)
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def async_op_url(data, extra_data = {})
          URI.join(
            'https://www.googleapis.com/sql/v1beta4/',
            expand_variables(
              'projects/{{project}}/operations/{{op_id}}',
              data, extra_data
            )
          )
        end

        def wait_for_operation(response, resource)
          op_result = return_if_object(response, 'sql#operation')
          return if op_result.nil?
          status = ::Google::HashUtils.navigate(op_result, %w[status])
          fetch_resource(
            resource,
            URI.parse(::Google::HashUtils.navigate(wait_for_completion(status,
                                                                       op_result,
                                                                       resource),
                                                   %w[targetLink])),
            'sql#instance'
          )
        end

        def wait_for_completion(status, op_result, resource)
          op_id = ::Google::HashUtils.navigate(op_result, %w[name])
          op_uri = async_op_url(resource, op_id: op_id)
          while status != 'DONE'
            debug("Waiting for completion of operation #{op_id}")
            raise_if_errors op_result, %w[error errors], 'message'
            sleep 1.0
            raise "Invalid result '#{status}' on gsql_instance." \
              unless %w[PENDING RUNNING DONE].include?(status)
            op_result = fetch_resource(resource, op_uri, 'sql#operation')
            status = ::Google::HashUtils.navigate(op_result, %w[status])
          end
          op_result
        end

        def raise_if_errors(response, err_path, msg_field)
          self.class.raise_if_errors(response, err_path, msg_field)
        end

        def self.fetch_resource(resource, self_link, kind)
          get_request = ::Google::Sql::Network::Get.new(
            self_link, fetch_auth(resource)
          )
          return_if_object get_request.send, kind
        end

        def self.raise_if_errors(response, err_path, msg_field)
          errors = ::Google::HashUtils.navigate(response, err_path)
          raise_error(errors, msg_field) unless errors.nil?
        end

        def self.raise_error(errors, msg_field)
          raise IOError, ['Operation failed:',
                          errors.map { |e| e[msg_field] }.join(', ')].join(' ')
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
