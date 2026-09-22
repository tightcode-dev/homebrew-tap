# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.1"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.1/tightcode-0.3.1-darwin-arm64.tar.gz"
    sha256 "39837011768efe610e1ed7a621258afb8c85c51c771edc7cc68e3b76896c88f4"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.1/tightcode-0.3.1-darwin-x64.tar.gz"
    sha256 "72cddfb4d9c6db06f382a3d6895e0ba14af2b7c5bf881bd2e0554b93926d2b85"
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
