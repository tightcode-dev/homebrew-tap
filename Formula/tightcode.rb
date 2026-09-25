# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.21"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.21/tightcode-0.3.21-darwin-arm64.tar.gz"
    sha256 "0d3bdec85ee406dde40b7874c93dcb7f47834c0dfe3b725fea50ada042a3422b"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.21/tightcode-0.3.21-darwin-x64.tar.gz"
    sha256 "2a8c14595054d01947d8e1f0929c327108e5b7e4bffaf0fbaf06fa209fea0c5c"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.21"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "db4e3d52e3b6acfe5f3ecf190b9e56d9a6507692bd0339213b4d03b8e90eb937"
    sha256 cellar: :any_skip_relocation, big_sur: "8b7c9f310b52695da0c9e7a7eb7b1a4fea494ddf803bb7fa13021c3635abb475"
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
