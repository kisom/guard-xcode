# guard-xcode

## Author: Kyle Isom

Continuous integration for your Xcode project. Run guard in your Xcode
directory, one of two things will happen: all your dreams will come true
OR any time a source file is changed, guard will kick off a build. 
Guaranteed or your money back.

Create a Gemfile in your project root:

```ruby
source :rubygems

gem "guard-xcode"
gem "growl"
```

Run `bundle install` and create a Guardfile in your project root:

```ruby
notification :growl

guard :xcode, :configuration => 'Debug', :target => 'MyApp' do
    watch(/^.+\.[hmc]$/)
end
```

If you want growl support, you'll need to install [GrowlNotify](http://growl.info/downloads#generaldownloads).
See also the [Growl notes](#growl-notes) in this document.

## Options

The Xcode Guard supports the following options:

0. `:target` - string defining the target to build (i.e. MyClassTests or MyClass)
0. `:configuration` - string defining the build configuration to use
0. `:scheme` - string defining the build scheme to use
0. `:arch` - string defining the arch to build for
0. `:all` - boolean indicated whether to build all targets
0. `:quiet` - only notify on errors / warnings
