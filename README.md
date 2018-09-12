# Melodic Ruby Gem [![Build Status](https://travis-ci.com/DWPHoldings/melodic-web-rubygem.svg?branch=master)](https://travis-ci.com/DWPHoldings/melodic-web-rubygem)

[Melodic][melodic-home] ruby gem for Ruby on Rails (Sprockets) and Hanami (formerly Lotus).

## Installation

Please see the appropriate guide for your environment of choice:

* [Ruby on Rails 4+](#a-ruby-on-rails) or other Sprockets environment.
* [Other Ruby frameworks](#b-other-ruby-frameworks) not on Rails.


### a. Ruby on Rails

Add `melodic` to your Gemfile:

```ruby
gem 'melodic', '1.0.0.alpha'
```

Ensure that `sprockets-rails` is at least v2.3.2.

`bundle install` and restart your server to make the files available through the pipeline.

Import Melodic styles in `app/assets/stylesheets/application.scss`:

```scss
// Custom melodic variables must be set or imported *before* melodic.
@import "melodic";
```

The available variables can be found [here](assets/stylesheets/melodic/_variables.scss).

Make sure the file has `.scss` extension (or `.sass` for Sass syntax). If you have just generated a new Rails app,
it may come with a `.css` file instead. If this file exists, it will be served instead of Sass, so rename it:

```console
$ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
```

Then, remove all the `*= require` and `*= require_tree` statements from the Sass file. Instead, use `@import` to import Sass files.

Do not use `*= require` in Sass or your other stylesheets will not be able to access the Melodic mixins and variables.

Melodic JavaScript depends on jQuery.
If you're using Rails 5.1+, add the `jquery-rails` gem to your Gemfile:

```ruby
gem 'jquery-rails'
```

Melodic tooltips and popovers depend on [popper.js] for positioning.
The `melodic` gem already depends on the
[popper_js](https://github.com/glebm/popper_js-rubygem) gem.

Add Melodic dependencies and Melodic to your `application.js`:

```js
//= require jquery3
//= require popper
//= require melodic-sprockets
```

While `melodic-sprockets` provides individual Melodic components
for ease of debugging, you may alternatively require
the concatenated `melodic` for faster compilation:

```js
//= require jquery3
//= require popper
//= require melodic
```

### b. Other Ruby frameworks

If your framework uses Sprockets or Hanami,
the assets will be registered with Sprockets when the gem is required,
and you can use them as per the Rails section of the guide.

Otherwise you may need to register the assets manually.
Refer to your framework's documentation on the subject.

## Configuration

### Sass: Autoprefixer

Melodic requires the use of [Autoprefixer][autoprefixer].
[Autoprefixer][autoprefixer] adds vendor prefixes to CSS rules using values from [Can I Use](http://caniuse.com/).

If you are using melodic with Rails, autoprefixer is set up for you automatically.
Otherwise, please consult the [Autoprefixer documentation][autoprefixer].

### Sass: Individual components

By default all of Melodic is imported.

You can also import components explicitly. To start with a full list of modules copy
[`_melodic.scss`](assets/stylesheets/_melodic.scss) file into your assets as `_melodic-custom.scss`.
Then comment out components you do not want from `_melodic-custom`.
In the application Sass file, replace `@import 'melodic'` with:

```scss
@import 'melodic-custom';
```

[melodic-home]: https://melodic.helloinspire.com/
[melodic-variables.scss]: https://github.com/DWPHoldings/melodic-web-rubygem/blob/master/templates/project/_melodic-variables.scss
[autoprefixer]: https://github.com/ai/autoprefixer
[popper.js]: https://popper.js.org
