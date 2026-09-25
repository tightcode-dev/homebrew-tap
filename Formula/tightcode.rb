# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.19"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.19/tightcode-0.3.19-darwin-arm64.tar.gz"
    sha256 "55b1164234295ac2fac66610d9ce5aeac7bec8d9ad543ae188088fa6fe2e2f76"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.19/tightcode-0.3.19-darwin-x64.tar.gz"
    sha256 "96f6da80e9170a9216b2b683d0fc81b00d6bd3f1065af3b9f50f8ba29fadaffe"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.19"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2ec2d33b9d7c9110e508042d846031147d8b3a13300a55f50146263c2735e815"
    sha256 cellar: :any_skip_relocation, big_sur: "1c0cbcbe7a21776fb65e1efcf5c3be7ae1cb7899eeb0a344b99d3cc9b72e7b55"
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
