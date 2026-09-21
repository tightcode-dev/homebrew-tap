# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.2.0"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.2.0/tightcode-0.2.0-darwin-arm64.tar.gz"
    sha256 "55d0d60470425540791ac5e7b014b592a4efaf027d99c666b4eb3320ba67d92c"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.2.0/tightcode-0.2.0-darwin-x64.tar.gz"
    sha256 "d5409c6870a0d557a7da668352c7216ecb044f80c79b82b5ce7074d31208ea24"
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
