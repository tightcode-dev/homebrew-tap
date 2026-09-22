# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.11"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.11/tightcode-0.3.11-darwin-arm64.tar.gz"
    sha256 "93ce5672f4fb65b4e1c777749e1080d170bb51b799165724226a6d61ef0ecd66"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.11/tightcode-0.3.11-darwin-x64.tar.gz"
    sha256 "eea91aa6c9f0dda4869aeb18c710e53c9bab624e00d32a966f2b31e04a43d73e"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.11"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "12cd09414a93d19e67f5aad306771b3a0d7e85812ffd88d880a2b7d0bc6f8398"
    sha256 cellar: :any_skip_relocation, big_sur: "9ac4528169fc2dc1c5c4c077201716dc96ae0b0f7426f6e67ccbd909c90425a4"
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
