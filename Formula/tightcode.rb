# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.13"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.13/tightcode-0.3.13-darwin-arm64.tar.gz"
    sha256 "664554f92748915d0c3a21c8c848ccb8d603d29b65e86d128bc7c80799566bd8"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.13/tightcode-0.3.13-darwin-x64.tar.gz"
    sha256 "1a715337162bcc1bfc5f92e4dfb5e26cfd40a5f28f600124bbe45c5cb4a8de42"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.13"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c15c4e21761640f2e606d51f4fb9350e02b8c04ae3b595c0a490798ce7af5df9"
    sha256 cellar: :any_skip_relocation, big_sur: "ba731da29aac0440dc57176f053383ca572224f4ebc4f14a8f4bc30617a4e3ad"
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
