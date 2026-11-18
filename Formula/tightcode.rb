# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.60"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.60/tightcode-0.3.60-darwin-arm64.tar.gz"
    sha256 "42dd7c80ef2f99d5c48d474d0baa703b746d4f68a1db1927b3dd65151de9e714"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.60/tightcode-0.3.60-darwin-x64.tar.gz"
    sha256 "42750065d7d5b657d50a4fea51c9d5c792a2a28ef99410d835e96b9050463dbe"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.60"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "244499d5bf11dc9ca1f6a53b35d68068baeaaaf86d193e2739b244a2f9cbd18a"
    sha256 cellar: :any_skip_relocation, big_sur: "75614d11a0bb9bbe61b12069c9b18fc3e93996e8827094e71ef89042689d647b"
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
