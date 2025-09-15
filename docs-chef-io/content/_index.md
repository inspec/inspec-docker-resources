+++
title = "About Chef InSpec Docker resources"
platform = "docker"
draft = false
gh_repo = "inspec-docker-resources"
linkTitle = "Docker resources"
summary = "Chef InSpec resources for auditing Docker"

[menu.docker]
title = "About resources"
identifier = "inspec/resources/docker/about"
parent = "inspec/resources/docker"
+++

This resource pack allows you to audit Docker environments, including containers, images, services, and plugins.

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
