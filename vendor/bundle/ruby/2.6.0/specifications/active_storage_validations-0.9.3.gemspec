# -*- encoding: utf-8 -*-
# stub: active_storage_validations 0.9.3 ruby lib

Gem::Specification.new do |s|
  s.name = "active_storage_validations".freeze
  s.version = "0.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Igor Kasyanchuk".freeze]
  s.date = "2021-05-07"
  s.description = "Validations for Active Storage (presence)".freeze
  s.email = ["igorkasyanchuk@gmail.com".freeze]
  s.homepage = "https://github.com/igorkasyanchuk/active_storage_validations".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Validations for Active Storage".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 5.2.0"])
      s.add_development_dependency(%q<combustion>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<mini_magick>.freeze, [">= 4.9.5"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 5.2.0"])
      s.add_dependency(%q<combustion>.freeze, ["~> 1.3"])
      s.add_dependency(%q<mini_magick>.freeze, [">= 4.9.5"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 5.2.0"])
    s.add_dependency(%q<combustion>.freeze, ["~> 1.3"])
    s.add_dependency(%q<mini_magick>.freeze, [">= 4.9.5"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
