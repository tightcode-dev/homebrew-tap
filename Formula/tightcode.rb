# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.29"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.29/tightcode-0.3.29-darwin-arm64.tar.gz"
    sha256 "b36da7a6d6eea58e5567ff505cae428e01d527c51d08dab4dfc4e40ea583d6d2"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.29/tightcode-0.3.29-darwin-x64.tar.gz"
    sha256 "5c13cfbde85bef28f03623d45577ee91501cd302f7153513b9ddb09f7a97dc7f"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.29"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d65e4361355fd4164c042224386529f32c688637165fca6c105c354f1c5de018"
    sha256 cellar: :any_skip_relocation, big_sur: "573b0a93b5bab5bedf066baff0f6a5a0d7c33a65044f07cb3c3946c84033b9be"
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
