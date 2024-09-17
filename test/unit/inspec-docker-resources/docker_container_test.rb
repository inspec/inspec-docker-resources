require "helper"
require "inspec-docker-resources/resources/docker_container"

class DockerContainerTest < Minitest::Test
  def setup
    @mock_inspec = mock("inspec")
    @mock_docker = mock("docker")
    @mock_containers = mock("containers")

    filtered_data = { "command" => "\"/bin/bash\"", "created" => "2021-07-19T14:05:23.456Z", "id" => "3def9aa450f8bd772c3d5b07e27ec934e5f58575e955367a0aca2d93e0687536", "image" => "nginx:latest", "labels" => { "app": "example" , "version": "1.5.4" }, "local_volumes" => "0", "mounts" => "", "names" => ["sleepy_khorana"], "networks": "bridge", "ports" => "", "running_for" => "29 minutes", "size" => "0 B", "status" => "Up 2 weeks" }
    @filter_object = DockerContainerFilter.new([filtered_data])
    @mock_inspec.stubs(:docker).returns(@mock_docker)
    @mock_docker.stubs(:containers).returns(@mock_containers)
    @mock_containers.stubs(:where).returns(@filter_object)
  end

  def test_docker_container_returns_image
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "nginx:latest", @resource.image, "Expected docker container image to be nginx:latest"
  end

  def test_docker_container_status_is_running
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal true, @resource.running?, "Expected docker container is running"
  end

  def test_docker_container_returns_status
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "Up 2 weeks", @resource.status, "Expected docker container returns status"
  end

  def test_docker_container_returns_labels
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal [{ app: "example", version: "1.5.4" }], @resource.labels, "Expected docker container returns labels"
  end

  def test_docker_container_returns_command
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "/bin/bash", @resource.command, "Expected docker container command to be /bin/bash"
  end

  def test_docker_container_returns_image_repo
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "nginx", @resource.repo, "Expected docker container image repo to be nginx"
  end

  def test_docker_container_returns_image_tag
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "latest", @resource.tag, "Expected docker container image tag to be latest"
  end

  def test_docker_container_returns_resource_id
    @resource = DockerContainer.new("sleepy_khorana")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "3def9aa450f8bd772c3d5b07e27ec934e5f58575e955367a0aca2d93e0687536", @resource.resource_id, "Expected docker container resource_id to be \"3def9aa450f8bd772c3d5b07e27ec934e5f58575e955367a0aca2d93e0687536\""
  end
end