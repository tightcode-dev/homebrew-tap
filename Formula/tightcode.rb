# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.8"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.8/tightcode-0.3.8-darwin-arm64.tar.gz"
    sha256 "06549b2714bb271543548feac7f2a93a53d7d5f2d9cb438b4f963bc072dc55a5"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.8/tightcode-0.3.8-darwin-x64.tar.gz"
    sha256 "ea8ad493b8869c0e5cfbc23a8c17d9eb578195d8845916842aa61346ba3cb697"
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
