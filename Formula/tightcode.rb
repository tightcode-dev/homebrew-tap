# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.41"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.41/tightcode-0.3.41-darwin-arm64.tar.gz"
    sha256 "32404a202449a421277f46035694414f2c51fc1a301e25756c8dbcd2451a59ab"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.41/tightcode-0.3.41-darwin-x64.tar.gz"
    sha256 "d6c67b2310db89a6d7d8d66c4e4a8d883067a8666a73a508c8ca2134f7b00dcc"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.41"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "98e86e97a40f7d1862de541bdc402c2381bbf030956fd1b93ab1ed67a2aa35f0"
    sha256 cellar: :any_skip_relocation, big_sur: "aadd77cec6dc620f7d34d66bf692957fb15ce8490e36cfc191ef5f2725fb5a9f"
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
