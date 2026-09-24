# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.16"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.16/tightcode-0.3.16-darwin-arm64.tar.gz"
    sha256 "28f41d0366e4ca0fe5315118a644d3146f957607b67e037f0b2d5d3836eb87c4"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.16/tightcode-0.3.16-darwin-x64.tar.gz"
    sha256 "e45898ddc7223c1105840b7a2d3a3c0386fcac6b08d26b7f3bde6285016320d2"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.16"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c6063c82c21210da76e471ff0db10dbe893fbdbe1dd13e781d229169cd0b226d"
    sha256 cellar: :any_skip_relocation, big_sur: "de5c16f28e58f50f84749c8c7c26e5a367266bc1e495ccf02058bfc154ef9966"
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
