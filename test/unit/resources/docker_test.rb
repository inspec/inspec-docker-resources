require "helper"
require 'json'
require_relative '../../../lib/inspec-docker-resources/resources/docker'

class DockerTest < Minitest::Test
  def setup
    @mock_inspec = mock('inspec')
    @mock_command = mock('command')
    @resource = Docker.new
  end

  def test_containers
    mock_containers_output = '{"command":"sh","createdat":"2021-07-07","ID":"1234","image":"alpine:latest","labels":"app=test","Mounts":"","names":"test_container","ports":"80/tcp","runningfor":"3 days","size":"0B","status":"Up"}'
    @mock_command.stubs(:stdout).returns(mock_containers_output)
    @mock_command.expects(:stdout).returns('Docker version 20.10.7, build f0df350')
    @mock_command.stubs(:exit_status).returns(0)
    @mock_inspec.expects(:command).with("docker ps -a --no-trunc --format '{\"Command\": {{json .Command}}, \"CreatedAt\": {{json .CreatedAt}}, \"ID\": {{json .ID}}, \"Image\": {{json .Image}}, \"Labels\": {{json .Labels}}, \"Mounts\": {{json .Mounts}}, \"Names\": {{json .Names}}, \"Ports\": {{json .Ports}}, \"RunningFor\": {{json .RunningFor}}, \"Size\": {{json .Size}}, \"Status\": {{json .Status}}}'").returns(@mock_command)
    @mock_inspec.expects(:command).with("docker version --format '{{ json . }}'").returns(@mock_command)
    @resource.expects(:inspec).twice.returns(@mock_inspec)
    containers = @resource.containers
    refute_empty containers.entries
    assert_equal 'alpine:latest', containers.entries[0]['image']
  end

  def test_images
    mock_images_output= '{"id":"abcd","repository":"test_repo","tag":"latest","size":"123MB","digest":"sha256:abcd","createdat":"2021-07-07","createdsize":"5 minutes"}'
    @mock_command.stubs(:stdout).returns(mock_images_output)
    @mock_inspec.expects(:command).with("docker images -a --no-trunc --format '{ \"id\": {{json .ID}}, \"repository\": {{json .Repository}}, \"tag\": {{json .Tag}}, \"size\": {{json .Size}}, \"digest\": {{json .Digest}}, \"createdat\": {{json .CreatedAt}}, \"createdsize\": {{json .CreatedSince}} }'").returns(@mock_command)
    @resource.expects(:inspec).returns(@mock_inspec)
    images = @resource.images
    refute_empty images.entries
    assert_equal 'test_repo', images.entries[0]['repository']
  end

  def test_plugins
    mock_plugins_output = '{"id":"abcd","name":"test_plugin","version":"1.0","enabled":true}'
    @mock_command.stubs(:stdout).returns(mock_plugins_output)
    @mock_inspec.expects(:command).with("docker plugin ls --format '{\"id\": {{json .ID}}, \"name\": \"{{ with split .Name \":\"}}{{index . 0}}{{end}}\", \"version\": \"{{ with split .Name \":\"}}{{index . 1}}{{end}}\", \"enabled\": {{json .Enabled}} }'").returns(@mock_command)
    @resource.expects(:inspec).returns(@mock_inspec)
    plugins = @resource.plugins
    refute_empty plugins.entries
    assert_equal 'test_plugin', plugins.entries[0]['name']
  end

  def test_services
    mock_services_output = '{"ID":"abcd","Name":"test_service","Mode":"replicated","Replicas":"1/1","Image":"test_image","Ports":"*80->8080/tcp"}'
    @mock_command.stubs(:stdout).returns(mock_services_output)
    @mock_inspec.expects(:command).with("docker service ls --format '{\"ID\": {{json .ID}}, \"Name\": {{json .Name}}, \"Mode\": {{json .Mode}}, \"Replicas\": {{json .Replicas}}, \"Image\": {{json .Image}}, \"Ports\": {{json .Ports}}}'").returns(@mock_command)
    @resource.expects(:inspec).returns(@mock_inspec)
    services = @resource.services
    refute_empty services.entries
    assert_equal 'test_service', services.entries[0]['name']
  end

  def test_version
    mock_version_output = '{"Client":{"Version":"20.10.7"},"Server":{"Version":"20.10.7"}}'
    @mock_command.stubs(:stdout).returns(mock_version_output)
    @mock_command.stubs(:exit_status).returns(0)
    @mock_inspec.stubs(:command).with("docker version --format '{{ json . }}'").returns(@mock_command)
    @resource.expects(:inspec).returns(@mock_inspec)
    version = @resource.version
    refute_nil version
    assert_equal '20.10.7', version['Client']['Version']
  end

  def test_info
    mock_info_output = '{"Containers":10,"Images":5,"Plugins":{"Volume":["local"],"Network":["bridge","host"]}}'
    @mock_command.stubs(:stdout).returns(mock_info_output)
    @mock_command.stubs(:exit_status).returns(0)
    @mock_inspec.stubs(:command).with("docker info --format '{{ json . }}'").returns(@mock_command)
    @resource.expects(:inspec).returns(@mock_inspec)
    info = @resource.info
    refute_nil info
    assert_equal 10, info['Containers']
  end

  def test_object
    mock_object_output = '[{"ID":"1234","Config":{"Image":"alpine:latest"}}]'
    @mock_command.stubs(:stdout).returns(mock_object_output)
    @mock_command.stubs(:exit_status).returns(0)
    @mock_inspec.stubs(:command).with("docker inspect 1234").returns(@mock_command)
    @resource.expects(:inspec).returns(@mock_inspec)
    object = @resource.object('1234')
    refute_nil object
    assert_equal 'alpine:latest', object['Config']['Image']
  end
end
