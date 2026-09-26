# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.25"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.25/tightcode-0.3.25-darwin-arm64.tar.gz"
    sha256 "e3161f22bf274c3db5c245c1f2bdbebf55dc82ba86f2d9f9ee97c83eca8a2b39"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.25/tightcode-0.3.25-darwin-x64.tar.gz"
    sha256 "f33a064632e72238ec6230ed3f554b69b219e2f0d7b0725b99bab985aa554596"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.25"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c61f48b9e3366882ab7f19145cf3dc652683deb37729e851423816c1e7f9b8c2"
    sha256 cellar: :any_skip_relocation, big_sur: "bbfa2e170a25132fa89e70ec54461876137ecf0ecad68c0522d2f69e199e0fcd"
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
