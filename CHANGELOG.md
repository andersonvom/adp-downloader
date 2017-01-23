Changelog
=========

## Unreleased

* -


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
