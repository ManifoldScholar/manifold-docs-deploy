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
set :bundle_gemfile, -> { release_path.join('Gemfile') }

# Yarn
set :yarn_flags, "--production"

namespace :deploy do

  desc 'Jekyll Build'
  task :jekyll_build do
    on roles(:web), in: :sequence, wait: 5 do
      within release_path  do
        execute :bundle, :exec, :jekyll, :build
      end
    end
  end

  desc 'Copy Jekyll favicon'
  task :jekyll_copy_favicon do
    on roles(:web), in: :sequence, wait: 5 do
      within release_path  do
        execute :cp, '_site/favicon.ico', '_site/docs/favicon.ico'
      end
    end
  end
end

before 'deploy:publishing', 'deploy:jekyll_build'

after 'deploy:publishing', 'deploy:jekyll_copy_favicon'
