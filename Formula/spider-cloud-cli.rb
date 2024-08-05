# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class SpiderCloudCli < Formula
    desc "Web crawling and scraping client for Spider Cloud written in Rust"
    homepage "https://github.com/spider-rs/spider-clients"
    url "https://github.com/spider-rs/spider-clients/releases/latest/download/spider-cloud-cli-mac.tar.gz"
    sha256 "03c32b1ea02799a27db69c1b6d9fbafc9dc395c0d32c3af21ef0c02e04433c48"
    version "0.1.0"
  
    def install
      bin.install "spider-cloud-cli"
    end
  end