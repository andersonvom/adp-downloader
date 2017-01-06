#!/usr/bin/env ruby

require_relative '../ipay/ipay'

http_client = IPay::HttpClient.new
downloader = IPay::Downloader.new(http_client)
downloader.get_all_statements
