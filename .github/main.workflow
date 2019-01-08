workflow "New workflow" {
  on = "push"
  resolves = [
    "Push complete message",
  ]
}

action "Login" {
  uses = "actions/docker/login@76ff57a"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["New push message"]
}

action "Build" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Login"]
  args = "build -t cgascoig/coffee-demo-front-end:${GITHUB_SHA} ."
}

action "Push" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Build complete message"]
  args = "push cgascoig/coffee-demo-front-end:${GITHUB_SHA}"
}

action "New push message" {
  uses = "cgascoig/actions/webexteams@master"
  secrets = ["WEBEX_TEAMS_ACCESS_TOKEN"]
  args = "--room Chris Gascoigne --message New push event"
}

action "Build complete message" {
  uses = "cgascoig/actions/webexteams@master"
  needs = ["Build"]
  secrets = ["WEBEX_TEAMS_ACCESS_TOKEN"]
  args = "--room Chris Gascoigne --message Docker image built"
}

action "Push complete message" {
  uses = "cgascoig/actions/webexteams@master"
  needs = ["Push"]
  args = "--room Chris Gascoigne --message Docker image pushed to registry"
  secrets = ["WEBEX_TEAMS_ACCESS_TOKEN"]
}
