# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

append :linked_dirs, '.bundle'

set :repo_url, "git@github.com:ManifoldScholar/manifold-docs-jekyll.git"
set :deploy_to, "/home/manifold_marketing/deploy-docs"

set :keep_releases, 5


# Ruby & Bundler
set :rbenv_type, :user
set :rbenv_ruby, '2.4.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# Yarn
set :yarn_flags, "--production"
