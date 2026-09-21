# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.1.0"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.1.0/tightcode-0.1.0-darwin-arm64.tar.gz"
    sha256 "62b4a13654e513bbc9be8df4500bcd61e857cf80a3ddc2e1957dd34ed6267e65"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.1.0/tightcode-0.1.0-darwin-x64.tar.gz"
    sha256 "71a75e12b4774565b90f6b142a07b674e8bd324aa06d3fd8ed3d0fc21e05518c"
  end

  depends_on :macos

  def install
    bin.install "tightcode"
  end

  def caveats
    <<~EOS
      Two steps finish the setup:
        tightcode login          sign in with the Google account you subscribed with
        tightcode install-hook   make git review every push on this Mac
      Tight Code runs the review with Claude Code, which must be installed and signed in.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tightcode version").strip
  end
end
