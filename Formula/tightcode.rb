# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.59"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.59/tightcode-0.3.59-darwin-arm64.tar.gz"
    sha256 "ca21e1ea4bbf89d63bda9c4a349b1284ad33d1a7b74acdfa11c0cc069dd58555"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.59/tightcode-0.3.59-darwin-x64.tar.gz"
    sha256 "0e60d39cb58b68fa350be0936035b746255c611a496a6561f0e17c43aef69075"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.59"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c2d85f7808fe3be10929f7dc8a63162e7a121eec750af4eefd261ba3c4d17e32"
    sha256 cellar: :any_skip_relocation, big_sur: "3355ed75c89c19f58152c55958e6faaabac75ea5b5d04a3d8b0868a336f403ee"
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
