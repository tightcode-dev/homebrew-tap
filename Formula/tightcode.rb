# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.45"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.45/tightcode-0.3.45-darwin-arm64.tar.gz"
    sha256 "080eca3b9a142ac68de9d42f55ac12dc5d2290772c59e218972d4fa94a14c18f"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.45/tightcode-0.3.45-darwin-x64.tar.gz"
    sha256 "791222215b0f9285af4296158fa31c134bfcefe46d9ef11df402ab0e797b7a67"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.45"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8681de9344b390006db116b8a081d2796c75ed25a35654c7b3a1479414f2ba38"
    sha256 cellar: :any_skip_relocation, big_sur: "88eb276e0273baae36edce922d64f6be0581338c1b28bde3292a03b3612367e7"
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
