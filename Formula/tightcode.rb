# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.18"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.18/tightcode-0.3.18-darwin-arm64.tar.gz"
    sha256 "bc50e958371f04290511bc18e03bf70669fb967bb339fb88cbdb73c749b991bb"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.18/tightcode-0.3.18-darwin-x64.tar.gz"
    sha256 "aa8193f67b3f99b3b385b7197448c34f7b58902ffcfe404279e1eed775d753c0"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.18"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "805380bc6cbea243dfb82d8d839ac0e0e25a21a2caf6183d07e436a67e223b41"
    sha256 cellar: :any_skip_relocation, big_sur: "5bce151be0be808f9e8047d19fd01ce30f9d3cad586935ea96ae258552722970"
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
