ADP Downloader
==============

This app automatically downloads all [ADP][] pay statements (pay stubs)
from [MyADP][] and stores both the JSON and the PDF version of the pay
statement.  If called multiple times, it will download only statements
that have not yet been downloaded.

## Installation

    gem install adp-downloader  # you might have to use sudo


## Upgrading

### 0.2.x --> 0.3.x

Non-interactive `netrc` authentication is currently not supported due to
ADP requiring javascript to perform login. Unfortunately, the only way
to use the app is to ask for the `smsession` cookie from `stdin`. :(

### 0.2.x --> 0.2.3

Statements can now be downloaded by employer/account. This is not a
breaking change, but if you want to start downloading statements from
multiple employers/accounts, you might want to consider moving all your
previous statements into a directory named after the employer. See
readme for details. Always backup your statements before upgrading and
running new versions.

### 0.1.x --> 0.2.x

Statements are stored by year and the app uses the PDF ID, that is
always available, instead of the ID of the detailed JSON, and statements
are also stored in directories by year.  You might want to save backup
your current statements and manually merge the ones that might not be
available anymore in the new folders.


## Usage

### Iterative

Go to the directory where you want the pay stubs to be saved and run:

    adp-downloader

    # if you want to download stubs from multiple employers/accounts
    adp-downloader --employer <employername>

Enter your credentials and profit: all pay statements currently
available will be downloaded, both in JSON and PDF formats.  When you
receive your next paycheck, just go back to the directory and re-run
`adp-downloader`.

### Unattended

If you want to run it automatically (e.g. in a cron job), create or edit
you local [`.netrc` file][netrc] (usually in your home directory, unless
you put it somewhere else) with your credentials:

    # in case of a single employer/account
    machine adp-downloader login ___username___ password ___password___

    # for multiple employers/accounts
    machine adp-downloader-employername login ___username___ password ___password___

Adding your credentials to this file will skip the interactive step.


## Disclaimer

This program is not afiliated with ADP.


## License

adp-downloader is released under the [GPL License][gpl].


[ADP]: https://www.adp.com/
[MyADP]: https://my.adp.com
[netrc]: https://www.gnu.org/software/inetutils/manual/html_node/The-_002enetrc-file.html
[gpl]: https://www.gnu.org/licenses/gpl-3.0-standalone.html
