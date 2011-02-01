# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{create_rails_mysql_db}
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dmitry Biryukov"]
  s.cert_chain = ["/home/dmitry/.gem/gem-public_cert.pem"]
  s.date = %q{2011-02-01}
  s.default_executable = %q{create_rails_mysql_db}
  s.description = %q{cli util to create database and username readed from config/database.yml}
  s.email = %q{dmitry@biryukov.net}
  s.executables = ["create_rails_mysql_db"]
  s.extra_rdoc_files = ["README", "bin/create_rails_mysql_db", "lib/create_rails_mysql_db.rb"]
  s.files = ["Manifest", "README", "Rakefile", "bin/create_rails_mysql_db", "create_rails_mysql_db.gemspec", "lib/create_rails_mysql_db.rb"]
  s.homepage = %q{https://github.com/dmitryz/create_rails_mysql_db}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Create_rails_mysql_db", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{create_rails_mysql_db}
  s.rubygems_version = %q{1.3.7}
  s.signing_key = %q{/home/dmitry/.gem/gem-private_key.pem}
  s.summary = %q{cli util to create database and username readed from config/database.yml}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
