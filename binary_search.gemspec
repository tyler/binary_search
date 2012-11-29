Gem::Specification.new do |s|
  s.name = %q{binary_search}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler McMullen"]
  s.date = %q{2008-12-29}
  s.description = %q{Binary search and index methods for Ruby Arrays.}
  s.email = %q{tbmcmullen@gmail.com}
  s.extensions = ["ext/extconf.rb"]
  s.files = ["README.textile", "VERSION.yml", "ext/extconf.rb", "ext/binary_search.c", "lib/binary_search/native.rb", "lib/binary_search/pure.rb", "lib/binary_search.rb"]
  s.homepage = %q{http://github.com/tyler/binary_search}
  s.require_paths = ["lib", "ext"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Binary search and index methods for Ruby Arrays.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
