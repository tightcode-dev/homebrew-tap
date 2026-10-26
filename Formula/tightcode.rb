# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.52"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.52/tightcode-0.3.52-darwin-arm64.tar.gz"
    sha256 "9c79aaed5cbcfdeb2e215b90674503b962ec3a078a21496f60288f64a6684f74"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.52/tightcode-0.3.52-darwin-x64.tar.gz"
    sha256 "4bdfeee494c96ddfc4954d00ee9356039a52e4a1cc406694a472f97bf5ce661e"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.52"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fcececc86a502b2420915dcb97aee2860738566a9da458625ae2248ce3815d86"
    sha256 cellar: :any_skip_relocation, big_sur: "f5c40b6dd3754f0f100860d06caa0d17912c3bdce40d69ef50eda533434749e0"
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
