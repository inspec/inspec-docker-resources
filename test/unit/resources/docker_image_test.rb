require 'helper'
require_relative "../../../lib/inspec-docker-resources/resources/docker_image"

class DockerImageTest < Minitest::Test
  def setup
    @mock_inspec = mock("inspec")
    @mock_docker = mock("docker")
    @mock_images = mock("images")

    @image_data = { "id" => "sha256:4a415e3663882fbc554ee830889c68a33b3585503892cc718a4698e91ef2a526", "repository" => "alpine", "tag" => "latest", "size" => "3.99 MB", "digest" => "\u003cnone\u003e", "createdat" => "2017-03-03 21 =>32 =>37 +0100 CET", "createdsize" => "7 weeks" }

    @filter_object = DockerImageFilter.new([@image_data])
    @mock_inspec.stubs(:docker).returns(@mock_docker)
    @mock_docker.stubs(:images).returns(@mock_images)
    @mock_images.stubs(:where).returns(@filter_object)
  end

  def test_docker_image_returns_repo_and_tag    
    @resource = DockerImage.new("alpine:latest")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "alpine:latest", @resource.image, "Expected image returns alpine:latest"
  end

  def test_docker_image_repo
    @resource = DockerImage.new("alpine:latest")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "alpine", @resource.repo, "Expected repo tags to include nginx:latest and nginx:1.19"
  end

  def test_docker_image_tag
    @resource = DockerImage.new("alpine:latest")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "latest", @resource.tag, "Expected tag to retun latest"
  end

  def test_docker_image_resource_id
    @resource = DockerImage.new("alpine:latest")
    @resource.stubs(:inspec).returns(@mock_inspec)
    assert_equal "sha256:4a415e3663882fbc554ee830889c68a33b3585503892cc718a4698e91ef2a526", @resource.resource_id, "Expected tag to retun latest"
  end
end