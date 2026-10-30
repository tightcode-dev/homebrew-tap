# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.53"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.53/tightcode-0.3.53-darwin-arm64.tar.gz"
    sha256 "29f0628a63e3701562654c8d845f874af4b9c414dac30ee01c3835add0c3763a"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.53/tightcode-0.3.53-darwin-x64.tar.gz"
    sha256 "914738b9e3cf0ae40ef127281cc8a5b4418d0b38b787c02e1c96437bfe936553"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.53"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "37f2568f6acb283a9b40f50fc59c30583fb6ecf22e4917457207cbbfaef97111"
    sha256 cellar: :any_skip_relocation, big_sur: "723a23831f2c7dbfeea938e70878021752c522984b8a826e8619a207a905bf5e"
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
