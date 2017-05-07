# How to speed up assets precompilation time?

This sample application presents whatever steps are necessary to speed up assets precompilation time.

## Stack

* Ruby on Rails 5
* ActiveAdmin
* AlchemyCMS
* CKeditor
* Bootstrap 4

## Branches
### `master`

Raw application state where precompilation time is slow.

### `speed-up`
Revised application state with speeded up assets precompilation process.

## Tips

* Do not bundle everything into one large file. Use CDN for tools like CKeditor and require only on those pages where is needed.

* `I18n-js` keep the translations in separate file. Configure only required languages, otherwise translations file may growth up very fast along with every new library. Doing so you'll avoid large compiled files which means faster compilation and page load.
```ruby
config.i18n.available_locales = %i(en)
```

* Remove `gem 'therubyracer'` from `Gemfile` as this gem use a very large amount of memory. Make sure that some latest version of Node is installed instead.
https://devcenter.heroku.com/articles/rails-asset-pipeline#therubyracer

* Do not use `require` `require_tree` and `require_self` in your SASS/SCSS files. They are very primitive and do not work well with Sass files. Instead, use Sass's native `@import` directive which sass-rails has customized to integrate with the conventions of your Rails projects.
https://github.com/rails/sass-rails#important-note

* In your SASS/SCSS files use `@import` directive carefully. Avoid importing the whole package assets as `@import 'compass';` when you can only do `@import 'compass/css3/flexbox'`.

* Avoid using `require_tree .` directive in your JS/COFFEE manifests. Let's imagine scenario when your app has an admin panel with separate assets:
```js
//** assets/javascripts/admin/admin.js

//= require admin/tab.js
//= ...
```
```js
//** assets/javascripts/application.js

//= require 'something'
//= require_tree . // BAD! it requires admin assets as well
```

* Check logs while compiling your assets. It's easy to override the default logger and see whats going on under the hood by accessing DEBUG mode.

```ruby
# /lib/tasks/assets.rake

require 'sprockets/rails/task'

Sprockets::Rails::Task.new(Rails.application) do |t|
  t.logger = Logger.new(STDOUT)
end
```

Rails 5.1 ships with awesome tools like Yarn and Webpack. I highly recommend to give it a try and use them. What you can gain is assets dependencies management, more efficient compilation process, hot-reloads your code without page refresh, ES6 support, PostCSS and many more!
