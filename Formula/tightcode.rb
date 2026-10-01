# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.33"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.33/tightcode-0.3.33-darwin-arm64.tar.gz"
    sha256 "a6c5883ab4b31f2fb603b3249c30c9dbf265e1136e754034aca28d1a5d943259"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.33/tightcode-0.3.33-darwin-x64.tar.gz"
    sha256 "0318aab5cc739d0e200cbdc28432ab1aa8f664e068d1b9447eb111dae842f2d9"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.33"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f1819caabe6e59f6b55afc248bd7205922dd751d5dfc3cb8e563786a0d0e0251"
    sha256 cellar: :any_skip_relocation, big_sur: "6c294700ff97e602d9f2ff5261f07cf0943da6d919cc4e8d405b108cfc17e9eb"
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
