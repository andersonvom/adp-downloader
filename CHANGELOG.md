Changelog
=========

## Unreleased

* -


## 0.4.0

* [53b2204][] Tax statements can no longer be downloaded

[53b2204]: ../../commit/53b2204


## 0.3.2

* [6d3edab][] Fix bug when displaying auth error messages

[6d3edab]: ../../commit/6d3edab


## 0.3.1

* [9236c97][] Display better error message on auth error

[9236c97]: ../../commit/9236c97


## 0.3.0

* [e05377b][] Disable netrc authentication in favor of cookie only :(

[e05377b]: ../../commit/e05377b


## 0.2.5

* [00e3ff6][] Gracefully handle empty tax or pay statements

[00e3ff6]: ../../commit/00e3ff6


## 0.2.4

* [91dfaaa][] Add --version cmdline option

[91dfaaa]: ../../commit/91dfaaa


## 0.2.3

* [f73306b][] Add employer cmdline option

[f73306b]: ../../commit/f73306b


## 0.2.1

* [88d8f76][] Add command line options to prevent output

[88d8f76]: ../../commit/88d8f76


## 0.2.1

* [#3][] Fixed bug with Tempfiles in older versions of ruby

[#3]: ../../issues/3


## 0.2.0

### Breaking changes:

* [481f738][] Use PDF ID instead of JSON ID for file names
* [8af8c55][] Add adjustment suffix to pay adjustment PDF files
* [5fb1fb9][] Organize downloaded files by year

[481f738]: ../../commit/481f738
[8af8c55]: ../../commit/8af8c55
[5fb1fb9]: ../../commit/5fb1fb9

**WARNING**: Do not run `adp-downloader` in the same directory as `v.0.1.4`.
Either move all old statements to a different directory or run it in a new
directory.  Once all statements are downloaded, you can manually move
previously downloaded old statements (those no longer available through the
API) into the correct new directories.  The names of older statements will
still have the old ID but since they're no longer available through the API,
this should not cause any problems.

### Other changes:

* [812fbfc][] Keep simple statement JSON info along with detailed JSON
* [481f738][] Download pay and tax statements
* [fdc5494][] Download pay statement JSON only when available

[812fbfc]: ../../commit/812fbfc
[481f738]: ../../commit/481f738
[fdc5494]: ../../commit/fdc5494


## 0.1.4

* [75bcbf9][] Use `.netrc` for storing credentials

[75bcbf9]: ../../commit/75bcbf9


## 0.1.3 [YANKED]
## 0.1.2 [YANKED]
## 0.1.1 [YANKED]
## 0.1.0 [YANKED]
