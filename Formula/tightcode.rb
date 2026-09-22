# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.5"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.5/tightcode-0.3.5-darwin-arm64.tar.gz"
    sha256 "ca9fbb345fcf7215cb3f5678dc1a2a1aae0cbe192669ff3a24c41258f965179c"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.5/tightcode-0.3.5-darwin-x64.tar.gz"
    sha256 "46f7cd02310b8fbafbfcae1368c1b23faabb17dc67039f89b056cc79fbd7b05e"
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
