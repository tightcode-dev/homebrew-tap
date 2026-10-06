# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.46"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.46/tightcode-0.3.46-darwin-arm64.tar.gz"
    sha256 "fe0d636759b1f3c02c3c7cb948094a0a6a23c35cd6e95e18f2e4200777761513"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.46/tightcode-0.3.46-darwin-x64.tar.gz"
    sha256 "93c1b19367d0966f99979d7a717da090f5ef82d86b2e614e6266fa0719d99146"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.46"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d0239cb0502394a5fdf1ea67989c27885da30ebf9c5649eb0ba69cc45160f252"
    sha256 cellar: :any_skip_relocation, big_sur: "463c88d3c7d173c9e1ecfe27eff5d790c837f8a890aac33e7aefe68fd0f34d8b"
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
