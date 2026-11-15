# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.57"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.57/tightcode-0.3.57-darwin-arm64.tar.gz"
    sha256 "d8fef5c31d4968e789aee03c57f483abd94646bd0b74011ac169b0825b5b89a8"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.57/tightcode-0.3.57-darwin-x64.tar.gz"
    sha256 "8856d3fc2b10c841846c9dba85076988a1f762fd89dd074c2b2a5b0c3a07f2e0"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.57"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4a06df2be79dd71e5c6b17b647cedb84c8532dcc9bef47ebd0710d63db6deab6"
    sha256 cellar: :any_skip_relocation, big_sur: "2be727ef78a7b5d4342c101dcdec4a151c5ff4677fe036ba47972a3ad9a7fcc2"
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
