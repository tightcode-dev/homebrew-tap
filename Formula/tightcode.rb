# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.6"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.6/tightcode-0.3.6-darwin-arm64.tar.gz"
    sha256 "3c479b4d8f4971692e67ae77e5912426535636c8170ebc87e23b8c7dbc72dac3"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.6/tightcode-0.3.6-darwin-x64.tar.gz"
    sha256 "637e469f6161c551b7f448ecf2f1fd799cbc2802098e74c39138bded39c46c8c"
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
