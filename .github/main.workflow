workflow "New workflow" {
  on = "push"
  resolves = ["Push"]
}

action "Login" {
  uses = "actions/docker/login@76ff57a"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Build" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Login"]
  args = "build -t cgascoig/coffee-demo-front-end:${GITHUB_SHA} ."
}

action "Push" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Build"]
  args = "push cgascoig/coffee-demo-front-end:${GITHUB_SHA}"
}
