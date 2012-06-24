Gem::Specification.new do |s|
  s.name = %q{belphanior-x10-servant}
  s.version = "0.0.1"
  s.date = %q{2011-02-13}
  s.authors = ["Mark T. Tomczak"]
  s.email = %q{iam+belphanior-x10-servant@fixermark.com}
  s.summary = %q{The Belphanior x10 Servant allows for control of an x10 system using the standard Belphanior home-network protocol. Currently works with the Smarthome 2412n home automation server.}
  s.description =  %q{See the documentation for more information. Documentation page coming soon.}
  s.add_dependency("belphanior-servant", ">= 0.0.1")
  s.files = [ "belphanior-x10-servant.gemspec",
              "lib/belphanior/servant/homenetwork/insteon_2412n_marshaller.rb",
              "lib/belphanior/servant/homenetwork/insteon_2412n_x10_codec.rb" ]
  s.test_files = Dir.glob('lib/belphanior/servant/homenetwork/test/tc_*.rb')
end
