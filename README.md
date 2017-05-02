[![Build Status](https://travis-ci.org/fulldecent/html-proofer-mailto-awesome.svg?branch=master)](https://travis-ci.org/fulldecent/html-proofer-mailto-awesome)

# html-proofer-mailto-awesome
A custom [html-proofer](https://github.com/gjtorikian/html-proofer) test that makes your `mailto:` links awesome.

## What is an awesome `mailto` link?

We should use awesome links as psychological warfare against users. Users will send us emails with stupid or annoying content that we don't want. At big companies (like Amazon) they have abandoned email altogether because of this reason. So instead we prefill the email with the message we want to receive. It takes active cognitive effort for the user to put in their unwanted message.

For example, this is a not-awesome `mailto` link:

```html
<a href="mailto:support@pacificmedicaltraining.com">Email us</a>
```

This is an awesome link:

```html
<a href="mailto:support@pacificmedicaltraining.com?subject=Signing up&amp;body=Hello,\nI'd like to sign up for your course, can you please send me more information.">Email us</a>
```

For more reference, see http://marcwitteveen.com/mailtogenerator/

## How do I use it

Follow the same instructions as for any html-proofer custom class. (LINK TO NEW HTML-PROOFER WIKI PAGE WITH THIS INFORMATION.)

Our ruby gemp is [html-proofer-mailto_awesome](https://rubygems.org/gems/html-proofer-mailto_awesome)

1. Create a Gemspec file like the following and add it to your project

       Gem
       Gem
       
2. Create a Rakefile like the following and add it to your project

       Rake
       Rake
       
3. Run `bundle install`

4. Run `rake`

Also if you like, you can enable your project for continuous integration testing with Travis:

1. Set up Travis CI for your project

2. Create a `.travis.yml` file like the following to your project

       Travis
       Travis
       
For additional tests you can run on your website, see [Lightning Sites](https://github.com/fulldecent/lightning-sites) and for a sample GitHub project that implements this testing and follows many other HTML development best practices, see [HTML Website Template](https://github.com/fulldecent/html-website-template).

For a full example of a website project that includes testing  continuous integration testing for awesome mailto links and many other best practices, see our 
       
## Contributing

This project is released under the MIT license.

Releasing new versions:

```sh
bump patch
gem build html-proofer-mailto_awesome.gemspec
gem push html-proofer-mailto_awesome-*.gem
```
