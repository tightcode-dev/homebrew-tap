# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.24"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.24/tightcode-0.3.24-darwin-arm64.tar.gz"
    sha256 "0f289fb25e4009263496c2a82b74600fa42bdd355ab958bf098428c9d25c3f5f"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.24/tightcode-0.3.24-darwin-x64.tar.gz"
    sha256 "b5222ac8f66fd5851949ccbd9c3d7e0b9d516a4c265068c6137119a7e6bc8631"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.24"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5a0ac9ecf0112f18e5c22f8fc2711c35816bda39977b42307b1ae6b182659959"
    sha256 cellar: :any_skip_relocation, big_sur: "6cf99a20aadf4cdc82f0d0429672786aed62f5ab97bee6432d3b63a12e921e82"
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
