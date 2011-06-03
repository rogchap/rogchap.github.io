task :default => :run

desc 'Build site with Jekyll'
task :build do
  jekyll
end

desc 'Build site and start server with --auto'
task :run do
  jekyll '--server --auto'
end

def jekyll(opts = '')
  sh 'rm -rf _site'
  sh 'jekyll ' + opts
end