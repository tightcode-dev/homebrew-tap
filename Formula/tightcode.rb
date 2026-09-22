# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.0"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.0/tightcode-0.3.0-darwin-arm64.tar.gz"
    sha256 "061159e84b9b21d4d830bf4265c82f7b6d191292c6beba79d7dbec57601f46d8"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.0/tightcode-0.3.0-darwin-x64.tar.gz"
    sha256 "bb686a7c32295f3322883dc96c92662f9b2668c5ac303b431d088eca7dfb9ce0"
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
