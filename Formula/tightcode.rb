# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.40"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.40/tightcode-0.3.40-darwin-arm64.tar.gz"
    sha256 "828057371e20cc1373f5c1c0cab83d48ca94664f1fe1f425c2503cc4ea39a372"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.40/tightcode-0.3.40-darwin-x64.tar.gz"
    sha256 "3eae5878cf9819839c74e03c1e7049663832d472d8fbf912e4e387fd393192bd"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.40"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c386cc3be0824c507e7ee37f8f1fb6c6cfa3851b0ce2fed7b0d5b88d0956f9e4"
    sha256 cellar: :any_skip_relocation, big_sur: "ac758fdf76fca0eab4bd591c805a0ffa4762fb29da61152cb3b2c52645801496"
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
