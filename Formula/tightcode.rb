# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.49"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.49/tightcode-0.3.49-darwin-arm64.tar.gz"
    sha256 "5738b3a0938abf3c708df10eef5554f03b5290bbe333cd96d421cf825f2fb83a"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.49/tightcode-0.3.49-darwin-x64.tar.gz"
    sha256 "026a4dbe1c69576d381126ea04871f91e6d11f0d00778b33360bdf2edd9f1215"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.49"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ab3c092806258fab63fba97308af1e31224943bd91162705717b0b9bb5295d07"
    sha256 cellar: :any_skip_relocation, big_sur: "507bb1649f67c28c2a7b739e180e66f551e2e2be432ceeec190eb9946a2a9690"
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
