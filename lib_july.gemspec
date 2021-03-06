# frozen_string_literal: true

require_relative "lib/july/version"

Gem::Specification.new do |spec|
  spec.name = "lib_july"
  spec.version = July::VERSION
  spec.authors = ["Toshiyuki-Yamashita"]
  spec.email = ["Toshiyuki-Yamashita@users.noreply.github.com"]

  spec.summary = "utility library for ruby"
  spec.description = "utility function collection"
  spec.homepage = "https://github.com/Toshiyuki-Yamashita/lib_july"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/Toshiyuki-Yamashita"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Toshiyuki-Yamashita/lib_july"
  spec.metadata["changelog_uri"] = "https://github.com/Toshiyuki-Yamashita/lib_july"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
