# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.51"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.51/tightcode-0.3.51-darwin-arm64.tar.gz"
    sha256 "4997d840570a6e52cdfea4d97ce45f74c459a3222e2e705f12aa7c96b05a4671"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.51/tightcode-0.3.51-darwin-x64.tar.gz"
    sha256 "44c2431c28d537bc52d31f87fc995caf15769406ba26d290092c73f1d7f84bab"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.51"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6309c1db6a18f22e16ac733127697cc62b98bfd10ff2588ab1e4c83d196d3832"
    sha256 cellar: :any_skip_relocation, big_sur: "b95e8f9ec4510337188f4695b09b41ea49c56f0a668a40ee8ca4f1a9d931eb33"
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
