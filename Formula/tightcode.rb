# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.27"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.27/tightcode-0.3.27-darwin-arm64.tar.gz"
    sha256 "c24190c0bcb888419cb08524226869384c4207bd6c18e9c78d0eb5a4757baaec"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.27/tightcode-0.3.27-darwin-x64.tar.gz"
    sha256 "07a22dc66019414249949d0112bac80e2cea025f118d2b429555b254bada7db0"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.27"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "75f0b4b011ed0ec7d04740f0150577238beb7281df3485b0cb426211ecce7ca2"
    sha256 cellar: :any_skip_relocation, big_sur: "39ee77da7e2ef251e99e15316df53018c2e870dc5d899ecd5d7735dd34bacde9"
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
