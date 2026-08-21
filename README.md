# chromedriver-install

## Description

Automatic selection and installation of the right chromedriver for your version of Chrome.

chromedriver has to match the Chrome it drives, and Chrome updates itself without asking, so the pairing comes apart on its own. `chromedriver-install` puts it back:

1. Works out which Chrome is installed, preferring the one Selenium keeps in `~/.cache/selenium/chrome`, then `~/Applications`, then `/Applications`.
2. Finds the newest chromedriver whose major, minor and tiny version numbers match that Chrome.
3. Fetches it — from the [Chrome for Testing](https://googlechromelabs.github.io/chrome-for-testing/) JSON API from version 116 onwards, and from the old chromedriver downloads page below that.
4. Unzips it, moves the binary to `~/bin/chromedriver`, makes it executable, and clears away the zip.

Both Apple silicon and Intel are handled, the architecture being read from `RUBY_PLATFORM`.

## Installation

### 0. Have a recent version of Ruby installed

### 1. Via Homebrew

```shell
$ brew tap thoran/tap
$ brew install thoran/tap/chromedriver-install
```

The formula installs `lib` alongside the script, which is where `Version` and `String/matches` come from. Installed any other way, `lib` has to be reachable — the script puts its own `../lib` on the load path, so a clone kept whole is enough.

## Dependencies

Three gems, all vendored by the formula:

1. [http.rb](https://github.com/thoran/http.rb), to fetch the downloads page and the JSON.
2. [nokogiri](https://nokogiri.org), to read the links out of the downloads page.
3. [rubyzip](https://github.com/rubyzip/rubyzip), to unpack the download.

## Usage

```shell
$ chromedriver-install
```

There is nothing to configure and no arguments to give. It prints the version it settles on, then says when it has finished.

## Notes

1. macOS only. Chrome's version is read with `defaults read`, and the downloads chosen are the `mac-x64` and `mac-arm64` ones.
2. The binary lands at `~/bin/chromedriver`, replacing whatever was there. `~/bin` has to exist already, and wants to be on your `PATH`.
3. Matching is on major, minor and tiny, so the fourth number may differ between your Chrome and its driver. That is the pairing chromedriver itself promises.
4. Selenium's cached Chrome is preferred over the installed application, on the reasoning that a suite driving that copy is what wanted the driver.
5. `~/Downloads` is used as the working directory, and the zip is removed afterwards.

## Contributing

1. Fork it: `https://github.com/thoran/chromedriver-install/fork`
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Create a new pull request
