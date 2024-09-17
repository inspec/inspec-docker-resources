require "helper"
require_relative "../../../lib/inspec-docker-resources/resources/docker_plugin"

class DockerPluginTest < Minitest::Test
  def setup
    @mock_inspec = mock("inspec")
    @mock_docker = mock("docker")
    @mock_plugins = mock("plugins")

    @plugin_data = { "id" => "6ea8176de74b", "name" => "store/weaveworks/net-plugin", "version" => "2.3.0", "enabled" => true }

    @filter_object = DockerPluginFilter.new([@plugin_data])
    @mock_inspec.stubs(:docker).returns(@mock_docker)
    @mock_docker.stubs(:plugins).returns(@mock_plugins)
    @mock_plugins.stubs(:where).returns(@filter_object)
  end

  def test_docker_plugin_id
    @resource = DockerPlugin.new("store/weaveworks/net-plugin")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "6ea8176de74b", @resource.id, "Expected plugin ID to be 6ea8176de74b"
  end

  def test_docker_plugin_version
    @resource = DockerPlugin.new("store/weaveworks/net-plugin")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "2.3.0", @resource.version, "Expected plugin version to be 2.3.0"
  end

  def test_docker_plugin_enabled
    @resource = DockerPlugin.new("store/weaveworks/net-plugin")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal true, @resource.enabled?, "Expected given plugin is enabled"
  end

  def test_docker_plugin_resource_id
    @resource = DockerPlugin.new("store/weaveworks/net-plugin")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "6ea8176de74b", @resource.resource_id, "Expected docker plugin resource id to be 6ea8176de74b"
  end
end
