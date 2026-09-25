# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.23"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.23/tightcode-0.3.23-darwin-arm64.tar.gz"
    sha256 "d6b7e2f1a7d3a19716524e34452a8aca3b97654e5ef38c8b088a2eac1a0d8ee0"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.23/tightcode-0.3.23-darwin-x64.tar.gz"
    sha256 "2abdae66fa2fcd7ca852d1320cb1de2ca0c1b18cfaeb7a67d81e4699131f34f1"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.23"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f1bcb46f16671b0dae555406539c35c8b261bfc44fdcb6a38d90799f9ae82869"
    sha256 cellar: :any_skip_relocation, big_sur: "213a486ebf5ee1af678c50f920982a5512ca7d734f71840cf4b31099181d3a79"
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
