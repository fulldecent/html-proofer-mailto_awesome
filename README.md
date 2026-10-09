# html-proofer-mailto_awesome

![Gem](https://img.shields.io/gem/v/html-proofer-mailto_awesome) [![Test](https://github.com/fulldecent/html-proofer-mailto_awesome/actions/workflows/ruby.yml/badge.svg)](https://github.com/fulldecent/html-proofer-mailto_awesome/actions/workflows/ruby.yml) [![Lint](https://github.com/fulldecent/html-proofer-mailto_awesome/actions/workflows/lint.yml/badge.svg)](https://github.com/fulldecent/html-proofer-mailto_awesome/actions/workflows/lint.yml)

An [html-proofer](https://github.com/gjtorikian/html-proofer) check that requires `mailto:` links to carry the header fields you want every message to start with.

## What an awesome mailto link is

People send email we did not ask for. A bare `mailto:` link opens a blank message, and the sender fills that blank with whatever is on their mind. Prefilling the subject and the body makes the useful message the path of least resistance. Replacing it takes effort.

This is a not-awesome link:

```html
<a href="mailto:support@pacificmedicaltraining.com">Email us</a>
```

This is an awesome link. The subject and the body are already there:

```html
<a
  href="mailto:support@pacificmedicaltraining.com?subject=Signing%20up&amp;body=Hello%2C%0AI%20would%20like%20to%20sign%20up."
>
  Email us
</a>
```

[RFC 6068](https://www.rfc-editor.org/rfc/rfc6068) is the `mailto:` URI scheme. In HTML, write `&amp;` for an ampersand inside the attribute. Header field names are case-insensitive. `Subject` and `subject` are the same field.

The same rule is published for HTML-validate as [`nice-checkers/mailto-awesome`](https://github.com/fulldecent/html-validate-nice-checkers#nice-checkersmailto-awesome).

## Installation

This gem runs on the Ruby branches that are still in normal or security maintenance: 3.3, 3.4, and 4.0. The list is [Ruby maintenance branches](https://www.ruby-lang.org/en/downloads/branches/). Install one of those Rubies from that page.

Add the gem to the application that builds or checks the site:

```ruby
gem "html-proofer-mailto_awesome"
```

Then install:

```sh
bundle install
```

## Usage

html-proofer runs only the checks named in `checks`. That option replaces the default list, which is `Links`, `Images`, and `Scripts`. Include those names when you still want them, and add `MailtoAwesome`.

Require this gem before `run`. html-proofer discovers the check by looking at classes that are already loaded.

```ruby
require "html-proofer"
require "html-proofer-mailto_awesome"

desc "Check the built site"
task :test do
  HTMLProofer.check_directory("_site", {
    checks: ["Links", "Images", "Scripts", "MailtoAwesome"],
  }).run
end

task default: :test
```

Run it with Bundler so the gem is on the load path:

```sh
bundle exec rake
```

`MailtoAwesome` looks at `a` elements. A `mailto:` link passes when every required header field is present. The default required fields are `subject` and `body`. An empty value still counts as present (`subject=`). Text in the address, such as `mailto:subject=trick@example.com`, is not a header field.

A link that omits a field fails with `mailto: link is missing required parameters: subject, body`. A `mailto:` value that Ruby cannot parse as a URI fails with `mailto: link is malformed and could not be parsed.`

`data-proofer-ignore` skips the link, as it does for the other html-proofer checks.

## Configuration

`mailto_awesome.required_parameters` replaces the default list. This matches the HTML-validate rule, which uses `requiredParameters` for the same purpose. Pass an empty array when you want the check loaded and no fields required.

```ruby
HTMLProofer.check_directory("_site", {
  checks: ["Links", "Images", "Scripts", "MailtoAwesome"],
  mailto_awesome: {
    required_parameters: ["subject", "body"],
  },
}).run
```

## Development

Clone the repository and install the gems it uses to test itself:

```sh
git clone https://github.com/fulldecent/html-proofer-mailto_awesome.git
cd html-proofer-mailto_awesome
bundle install
bundle exec rake
```

Format the files the lint workflow checks. These commands call `@latest` on purpose. A pinned copy would let your machine rewrite files one way and continuous integration reject them another way. [node.js-template](https://github.com/fulldecent/node.js-template) records that constraint on its `format` script.

```sh
npx prettier@latest --write .
npx markdownlint-cli@latest --fix "**/*.md" --ignore node_modules
```

`*.md` is in `.prettierignore`. Prettier does not wrap Markdown. markdownlint does, and [`.markdownlint.json`](.markdownlint.json) turns off the line-length rule.

## Releasing

```sh
gem install bump
bump patch   # or minor, or major
rm -f html-proofer-mailto_awesome-*.gem
gem build html-proofer-mailto_awesome.gemspec
gem push html-proofer-mailto_awesome-*.gem
```

Rubygems requires MFA for this gem (`rubygems_mfa_required`).

## Maintenance

Do this every month or so:

1. Read [Ruby maintenance branches](https://www.ruby-lang.org/en/downloads/branches/). Update `required_ruby_version` and the Ruby matrix in [`.github/workflows/ruby.yml`](.github/workflows/ruby.yml) when a branch leaves security maintenance, or when a new branch enters normal maintenance.
1. Review external actions in [`.github/workflows`](.github/workflows). GitHub-supported actions, the ones under the `actions/` organization, need a short review. `ruby/setup-ruby` is not one of those. Read its changelog before moving the tag.
1. Review `html-proofer` against the [5.x releases](https://github.com/gjtorikian/html-proofer/releases). This gem depends on `~> 5.0`, `>= 5.0.4`. It also depends on `logger`, because [Ruby 4.0 removed that library from the default gems](https://stdgems.org/libraries/logger/) and html-proofer still loads it.
1. Keep `ffi` at 1.17.4 or newer, and `nokogiri` at 1.19.0 or newer, in `Gemfile.lock`. The x86_64-linux builds of ffi 1.17.2 and nokogiri 1.18.10 set `required_ruby_version` to `< 3.5.dev`, so `bundle install` fails on Ruby 4.0. ffi 1.17.4 and nokogiri 1.19.4 allow Ruby before 4.1. ethon pulls in ffi. html-proofer pulls in nokogiri.

## References

1. We use title case for titles and proper nouns; not for headings and things. This includes our README above as well as our workflow rules and other configuration files. If you have a different policy, then please implement it throughout.
1. This project is released under the [MIT license](LICENSE).
1. This project is built based on [best practices documented in node.js-template](https://github.com/fulldecent/node.js-template). We took its lint workflow (Prettier and markdownlint, both invoked as `npx @latest`), [`.editorconfig`](.editorconfig), [`.markdownlint.json`](.markdownlint.json), [`.prettierignore`](.prettierignore), and this references section. We did not take its Yarn install or its `.node-version` pin. This is a Ruby gem. The lint job uses Node only as the tool runtime for those two checkers.
1. The check follows [`nice-checkers/mailto-awesome`](https://github.com/fulldecent/html-validate-nice-checkers#nice-checkersmailto-awesome) in [@fulldecent/nice-checkers-plugin](https://github.com/fulldecent/html-validate-nice-checkers): default required fields are `subject` and `body`, and the caller can replace that list. Delta: this gem compares header field names case-insensitively because [RFC 6068 section 2](https://www.rfc-editor.org/rfc/rfc6068#section-2) says `<hfname>` is case-insensitive. The HTML-validate rule uses `URLSearchParams`, which compares names case-sensitively.
1. html-proofer custom checks are loaded by class name and selected with the `checks` option. Passing `checks` replaces the default list. That behavior is documented in the [html-proofer README](https://github.com/gjtorikian/html-proofer#custom-tests).
1. Ruby versions in the gemspec and in continuous integration are the branches still in normal or security maintenance, from [Ruby maintenance branches](https://www.ruby-lang.org/en/downloads/branches/). Ruby 4.0 does not ship `logger` as a default gem. This gem depends on the [`logger` gem](https://stdgems.org/libraries/logger/) so html-proofer can load on that Ruby.
