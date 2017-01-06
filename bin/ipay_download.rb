#!/usr/bin/env ruby

require_relative '../ipay/ipay'

session_cookie = IPay::Auth.new.session_cookie
http_client = IPay::HttpClient.new(session_cookie)
downloader = IPay::Downloader.new(http_client)
downloader.get_all_statements
