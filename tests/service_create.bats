#!/usr/bin/env bats
load test_helper

@test "($PLUGIN_COMMAND_PREFIX:create) success" {
  run dokku "$PLUGIN_COMMAND_PREFIX:create" l
  assert_contains "${lines[*]}" "container created: l"
}

@test "($PLUGIN_COMMAND_PREFIX:create) error when there are no arguments" {
  run dokku "$PLUGIN_COMMAND_PREFIX:create"
  assert_contains "${lines[*]}" "Please specify a name for the service"
}

@test "($PLUGIN_COMMAND_PREFIX:create) creates version 5.6.14" {
  mv "tests/bin/docker" "tests/bin/docker-stub"
  export ELASTICSEARCH_IMAGE_VERSION="5.6.14"
  run dokku "$PLUGIN_COMMAND_PREFIX:create" l
  assert_contains "${lines[*]}" "container created: l"
  run dokku "$PLUGIN_COMMAND_PREFIX:list"
  assert_contains "${lines[*]}" "l     elasticsearch:5.6.14  running  -              -"
  export ELASTICSEARCH_IMAGE_VERSION="2.3.5"
  mv "tests/bin/docker-stub" "tests/bin/docker"
}

@test "($PLUGIN_COMMAND_PREFIX:create) creates version 6.5.4" {
  mv "tests/bin/docker" "tests/bin/docker-stub"
  export ELASTICSEARCH_IMAGE_VERSION="6.5.4"
  run dokku "$PLUGIN_COMMAND_PREFIX:create" l
  assert_contains "${lines[*]}" "container created: l"
  run dokku "$PLUGIN_COMMAND_PREFIX:list"
  assert_contains "${lines[*]}" "l     elasticsearch:6.5.4  running  -              -"
  export ELASTICSEARCH_IMAGE_VERSION="2.3.5"
  mv "tests/bin/docker-stub" "tests/bin/docker"
}

@test "($PLUGIN_COMMAND_PREFIX:create) creates version 2.3.5" {
  mv "tests/bin/docker" "tests/bin/docker-stub"
  export ELASTICSEARCH_IMAGE_VERSION="2.3.5"
  run dokku "$PLUGIN_COMMAND_PREFIX:create" l
  assert_contains "${lines[*]}" "container created: l"
  run dokku "$PLUGIN_COMMAND_PREFIX:list"
  assert_contains "${lines[*]}" "l     elasticsearch:2.3.5  running  -              -"
  export ELASTICSEARCH_IMAGE_VERSION="2.3.5"
  mv "tests/bin/docker-stub" "tests/bin/docker"
}
