# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.58"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.58/tightcode-0.3.58-darwin-arm64.tar.gz"
    sha256 "d99cafb4f7ddf704cc7f333af2d3b0c40fcde2715c18addb24c74b5df57b7882"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.58/tightcode-0.3.58-darwin-x64.tar.gz"
    sha256 "a1ccb598734d11585e34d2e0eb2b536b1ad1557cf4d35d48220a22eefaefe420"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.58"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "64b1a043c424add4e0d44b638ba06190998acfc47622017cb2231c6a9a25833c"
    sha256 cellar: :any_skip_relocation, big_sur: "724a1415c6ff0a120b890c6e09c4f5e9b4d16111d9b5eb038d9b902976c96090"
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
