# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.34"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.34/tightcode-0.3.34-darwin-arm64.tar.gz"
    sha256 "30179ffe991113049dc87b799b490c948a4bc3f3c744736d31b0f757b45a60b1"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.34/tightcode-0.3.34-darwin-x64.tar.gz"
    sha256 "e9e280d048f313b716e07805a590cbf3f873f7c46af75769363e3455c9b20001"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.34"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6ce426435cb79295f22f97e4d988a70e3cd8cfd2d891bf602e4a9248651e0321"
    sha256 cellar: :any_skip_relocation, big_sur: "2a276d437abb5deefefdc7e385e700a2d4c0d752579df0b235bd8a5a77059ce2"
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
