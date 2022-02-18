# LibJuly

LibJuly is some functions and classes that can use well in ruby programming.
This project is for my learning ruby gem development.
Of cource you can use LibJuly  free.
## Installation

Add this line to your application's Gemfile:

```ruby
source "https://rubygems.pkg.github.com/Toshiyuki-Yamashita" do
    gem 'lib_july'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lib_july

## Usage

* module July::String::Case

`String#case` can use like 'case/when' statement with method chain instead of syntax.
`#when` takes Regexp objects and a block.
When the string  matched to one of Regexp objects, the block would be invoked with the string and MatchData object.
if one `#when` matched, the others couldn't match anymore.
`#else` takes a block. When all `#when` could't match, the block would be invoked with the string.
This statement returns the return value of the block invoked from `#when` or `#else`, otherwise nil.

```ruby
require 'july/string/case'

using July::String::Case
["abcde", "12345", "++++"].each do |s|
  puts  s.case
        .when(/a/) {|m| [s, m].join(',')}
        .when(/1/,/b/) {|m| [s, m].join(',')}
        .else{ |str| "not matched"}
end
# =>
# abcde,a
# 12345,1
# not matched
```
`#case` can take block to customize the  comparison between the string and pattern in `#when` method.
When the block returned nil, the comparison would be false.
Otherwise, the block must return Array, which would be passed as the block parameter of `#when` method.

```ruby
puts "abcde".case { |str, pattern | str.match(pattern)&.captures}
        .when(/(a)/) {|c| c}
        .when(/1/,/b/) {|c| c}
        .else{ "not matched"}
# =>
# a
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.pkg.github.com](https://rubygems.pkg.github.com/Toshiyuki-Yamashita).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Toshiyuki-Yamashita/lib_july.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
