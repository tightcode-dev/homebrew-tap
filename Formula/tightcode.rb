# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.56"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.56/tightcode-0.3.56-darwin-arm64.tar.gz"
    sha256 "24925eb6607bd31b1a9357909e6065218cd0b3093d7b1e3a238e97d5f287dbdd"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.56/tightcode-0.3.56-darwin-x64.tar.gz"
    sha256 "62039df996cc17744c9cc943bfd8a5f3c98cb35ede66fec1c6d21dc526f532f3"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.56"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "07b98bc9388a6ca1d5e1ba740dc53ab1f5d5bd8611bbd1162975afb6d228d6b4"
    sha256 cellar: :any_skip_relocation, big_sur: "bc8508e8ed499f4e9fc2f01367fdc9a9cd42667bcd95dcf6946c5242080d159a"
  end

  depends_on :macos

  def install
    bin.install "tightcode"
  end

  def caveats
    <<~EOS
      First install: two steps finish the setup, and one command checks it.
        tightcode login          sign in with the Google account you subscribed with
        tightcode install-hook   make git review every push on this Mac
        tightcode doctor         check everything, with the fix for anything wrong
      Upgrade: run `tightcode status` once, so the dashboard sees the new version now
      (Homebrew cannot tell it for you). Tight Code runs the review with Claude Code,
      which must be installed and signed in.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tightcode version").strip
  end
end
