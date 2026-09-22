# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.9"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.9/tightcode-0.3.9-darwin-arm64.tar.gz"
    sha256 "07366db407108d49e0b4ad4dc4ebf350d1c9328d046eae34a1e243e267431b55"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.9/tightcode-0.3.9-darwin-x64.tar.gz"
    sha256 "4e2e5e5477ecef0e7a2c52436567272883344515d325990c222a37f45220e107"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "546f6f7c6912eb79fe3147dff6cb7a65cf522a99c12d9e75d967321fa818cca3"
    sha256 cellar: :any_skip_relocation, big_sur: "5467d7506397aab9bfd6838a4cab3a53e56492a506f6a2a70a07061b4f2155e3"
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
