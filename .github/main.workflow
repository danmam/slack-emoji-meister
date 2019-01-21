workflow "Lint and Build" {
  on = "push"
  resolves = ["Lint", "Build"]
}

workflow "Lint, Build and Publish" {
  on = "push"
  resolves = ["Publish"]
}

action "Install" {
  uses = "actions/npm@master"
  args = "ci"
}

action "Lint" {
  needs = "Install"
  uses = "actions/npm@master"
  args = "run lint"
}

action "Build" {
  needs = "Install"
  uses = "actions/npm@master"
  args = "run build"
}

action "BranchFilter" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "TagFilter" {
  uses = "actions/bin/filter@master"
  args = "tag"
}

action "Publish" {
  needs = ["BranchFilter", "TagFilter", "Lint", "Build"]
  uses = "actions/npm@master"
  args = "run build"
}
