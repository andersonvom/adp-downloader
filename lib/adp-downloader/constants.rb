require "io/console"
require "netrc"

module ADPDownloader
  MACHINE_NAME = "adp-downloader"

  BASE_URL = "https://my.adp.com"
  TARGET_URL = "#{BASE_URL}/static/redbox/"

  LOGIN_URL = "https://agateway.adp.com/siteminderagent/forms/login.fcc"
  PAY_STATEMENTS_PATH = "/v1_0/O/A/payStatements?adjustments=yes&numberoflastpaydates=100"
  TAX_STATEMENTS_PATH = "/v1_0/O/A/workerTaxStatements"
end
