# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.44"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.44/tightcode-0.3.44-darwin-arm64.tar.gz"
    sha256 "13c2c1a4c1e4abe27b4303187b009a5f4b21f7c6c85d6f0b9586ae4430f93a60"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.44/tightcode-0.3.44-darwin-x64.tar.gz"
    sha256 "2085d1543b4e4476ed0f3a3a17ec29e47a34d9fc601e2b367eddaddcacae215d"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.44"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b65016ac837d23a301be9c1717b98b5b5063f5db969f539935cbac751f2a7a73"
    sha256 cellar: :any_skip_relocation, big_sur: "f7e8864e5afe42843a182c07ef53250a81752df06821cb470dd5be4f613ec3bc"
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
