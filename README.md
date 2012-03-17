# guard-xcode

Continuous integration for your Xcode project. Run guard in your Xcode
directory, one of two things will happen: all your dreams will come true
OR any time a source file is changed, guard will kick off a build. 
Guaranteed or your money back.

## Prerequisites
You need `bundler`. If you've never used `Bundler` before, you'll need to 
install the `bundler` gem:

```bash
gem install Bundler 
```

(You may need to run this as `sudo`.)


## Getting started
Create a Gemfile in your project root:

```ruby
source :rubygems

gem "guard-xcode"
gem "growl"
```

Run `bundle install` and run `guard xcode` in your project root. You may wish
to review the generate Guardfile. At the minimum, you should change the target
to reflect the target you want to build on change (or use `:all => true`).

If you want growl support, you'll need to install [GrowlNotify](http://growl.info/downloads#generaldownloads).
See also the [Growl notes](#growl-notes) in this document.

## Options

The Xcode Guard supports the following options:

* `:target` - string defining the target to build (i.e. MyClassTests or MyClass)
* `:configuration` - string defining the build configuration to use
* `:scheme` - string defining the build scheme to use
* `:arch` - string defining the arch to build for
* `:all` - boolean indicated whether to build all targets. If true, overrides :target.
* `:quiet` - only notify on errors / warnings

<a name="growl-notes">
## Growl Notes
</a>
There are two options for Growl support:

* the `growl` gem
* the 'growl_notify' gem

### `growl`
This is a safe default, but requires you to download [GrowlNotify](http://growl.info/downloads#generaldownloads).
This is enabled by default. If you are using the stock version of Ruby shipped
with OS X, this is what you'll want to use. (Also, if you're using JRuby, 
you'll need to use this.)

### `growl_notify`
If you're using a version of Growl from the App Store, i.e. a version >= 1.3, 
and you're not using JRuby or MacRuby (the default shipped with OS X), you
can use this. Instead of `gem "growl"` in your `Gemfile`, you'll want to
use `gem "growl_notify"`. Then, in your Guardfile, you'll need to change the
`notification :growl` line to `notification :growl_notify`.