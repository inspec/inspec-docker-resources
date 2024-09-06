require 'helper'
require_relative "../../../lib/inspec-docker-resources/resources/docker_service"

class DockerServiceTest < Minitest::Test
  def setup
    @mock_inspec = mock("inspec")
    @mock_docker = mock("docker")
    @mock_services = mock("services")

    @service_data = {"id" => "2ghswegspre1", "name" => "service1", "mode" => "replicated", "replicas" => "3/3", "image" => "foo/image:1.0", "ports" => "*:1234->1234/tcp"}

    @filter_object = DockerServiceFilter.new([@service_data])
    @mock_inspec.stubs(:docker).returns(@mock_docker)
    @mock_docker.stubs(:services).returns(@mock_services)
    @mock_services.stubs(:where).returns(@filter_object)
  end

  def test_service_id
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "2ghswegspre1", @resource.id, "Expected docker serviceID to be 2ghswegspre1"
  end

  def test_service_name
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "service1", @resource.name, "Expected docker service name to be my-service"
  end

  def test_service_mode
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "replicated", @resource.mode, "Expected docker service mode to be replicated"
  end

  def test_service_replicas
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "3/3", @resource.replicas, "Expected number of replicas to be 3/3"
  end

  def test_service_image
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "foo/image:1.0", @resource.image, "Expected docker service image to be foo/image:1.0"
  end

  def test_service_ports
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "*:1234->1234/tcp", @resource.ports, "Expected docker service ports to match"
  end

  def test_service_resource_id
    @resource = DockerService.new("service1")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "2ghswegspre1", @resource.resource_id, "Expected docker service resource_id to be 2ghswegspre1"
  end
end
