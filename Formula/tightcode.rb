# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.35"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.35/tightcode-0.3.35-darwin-arm64.tar.gz"
    sha256 "c088d046443d5df47e24f5fdc89ab01cb51c2283a61f3dc24bbe36133f89809d"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.35/tightcode-0.3.35-darwin-x64.tar.gz"
    sha256 "928f74a1cd7b3d166e0f3144dfefcd5e7aa0ead0d3e4114b5d91ca044f206a47"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.35"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "84b4df04acf9243fd7e5d901c355934abf5b4c9bfebddfba94873c0686d40339"
    sha256 cellar: :any_skip_relocation, big_sur: "6fc8f1c9c49880068e9d7384edb586a23c92ba41f0ba641321ebcae2853fa39c"
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
