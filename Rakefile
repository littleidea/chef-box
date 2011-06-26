#-*- mode: ruby; -*-

[ :lucid, :maverick, :natty ].each do |release|
  [ 32, 64 ].each do |architecture|
    flavor = "#{release}#{architecture}"
    ( @flavors ||= [] ) << flavor
    desc "Build #{flavor}"
    task flavor do
      [ :build, :export, :destroy ].each do |command|
        sh "bundle exec vagrant basebox #{command} #{flavor}"
      end
    end
  end
end

desc "Build all"
task :all => @flavors
