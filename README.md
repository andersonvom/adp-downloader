ADP Downloader
==============

This app automatically downloads all ADP iPay pay statements (pay stubs)
from ADP and stores both the JSON and the PDF version of the pay
statement.  If called multiple times, it will download only statements
that have not yet been downloaded.

### Installation

    gem install adp-downloader


### Usage

Go to the directory where you want the pay stubs to be saved and run:

    adp-downloader

Enter your credentials and profit: all pay statements currently
available will be downloaded.  When you receive your next paycheck, just
go back to the directory and re-run `adp-downloader`.

If you want to run it automatically (e.g. in a cron job), create a
`credentials.json` file in your directory of choice first:

    {
      "username": "--some-username--",
      "password": "--some-password--"
    }

Creating this file will skip the interactive step.
