# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.4"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.4/tightcode-0.3.4-darwin-arm64.tar.gz"
    sha256 "d4983cb4aeb545a486da9e2a0254c5eb1f48402ce243261826dcea3b22bec0d4"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.4/tightcode-0.3.4-darwin-x64.tar.gz"
    sha256 "6676e1e5c93ef7dadabd184bbf0f5c16bc666523c719a18a6bf66193d69a7abb"
  end

  depends_on :macos

  def install
    bin.install "tightcode"
  end

  def caveats
    <<~EOS
      First install: two steps finish the setup.
        tightcode login          sign in with the Google account you subscribed with
        tightcode install-hook   make git review every push on this Mac
      Upgrade: run `tightcode status` once, so the dashboard sees the new version now
      (Homebrew cannot tell it for you). Tight Code runs the review with Claude Code,
      which must be installed and signed in.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tightcode version").strip
  end
end
