desc "Import an existing repositoy"
task :import, [:repo] do |t, args|
  repo = args.fetch(:repo)
  prefix = repo.pathmap("%n")
  sh "git subtree add --prefix #{prefix} #{repo} master --squash"
end
