+++
title = "About the Chef InSpec Docker resource pack"
draft = false
linkTitle = "Docker resource pack"
summary = "Chef InSpec resources for auditing Docker"

[cascade]
  [cascade.params]
    platform = "docker"

[menu.docker]
title = "About Docker resources"
identifier = "inspec/resources/docker/about"
parent = "inspec/resources/docker"
weight = 10
+++

The Chef InSpec Docker resource pack allows you to audit Docker environments, including containers, images, services, and plugins.

## Support

The InSpec Docker resources were part of InSpec core through InSpec 6.
Starting in InSpec 7, they're released separately as a Ruby gem.

## Usage

To add this resource pack to an InSpec profile, add the `inspec-docker-resources` gem as a dependency in your `inspec.yml` file:

```yaml
depends:
  - name: inspec-docker-resources
    gem: inspec-docker-resources
```

## Docker resources

{{< inspec_resources_filter >}}

The following Chef InSpec Docker resources are available in this resource pack.

{{< inspec_resources section="docker" platform="docker" >}}
