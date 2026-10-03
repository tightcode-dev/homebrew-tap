# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.37"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.37/tightcode-0.3.37-darwin-arm64.tar.gz"
    sha256 "113fa618cbf24340d869f58c1b4739b0dad2223a91d91c541c675590510a59a6"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.37/tightcode-0.3.37-darwin-x64.tar.gz"
    sha256 "92967836726dde38e636d4dcb6c8c4c68d4c38333f4a1edda46174e20fa51796"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.37"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "36ccb5932ac2843b86b0b104826c53f37c2592d3d25357346052bd544242bcc5"
    sha256 cellar: :any_skip_relocation, big_sur: "c5fb5994748d9c5dcb4a54462929d35b3872af1df49f582cfc93649813196155"
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
