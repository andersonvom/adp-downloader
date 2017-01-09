ADP Downloader
==============

This app automatically downloads all [ADP][] pay statements (pay stubs)
from [MyADP][] and stores both the JSON and the PDF version of the pay
statement.  If called multiple times, it will download only statements
that have not yet been downloaded.

## Installation

    gem install adp-downloader


## Usage

Go to the directory where you want the pay stubs to be saved and run:

    adp-downloader

Enter your credentials and profit: all pay statements currently
available will be downloaded.  When you receive your next paycheck, just
go back to the directory and re-run `adp-downloader`.

If you want to run it automatically (e.g. in a cron job), create or edit
you local `.netrc` file (usually in your home directory, unless you put
it somewhere else) with your credentials:

    machine adp-downloader login "--your-username" password "--your-password--""

Creating this file will skip the interactive step.


## Disclaimer

This program is not afiliated with ADP.


## License

adp-downloader is released under the [GPL License][gpl].


[ADP]: https://www.adp.com/
[MyADP]: https://my.adp.com
[gpl]: https://www.gnu.org/licenses/gpl-3.0-standalone.html
