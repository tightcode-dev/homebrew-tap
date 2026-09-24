# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.17"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.17/tightcode-0.3.17-darwin-arm64.tar.gz"
    sha256 "ceb1c812fdab6210fc4b69737fe6522599cd5b3b2c56976e709a76f0e49fbdb7"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.17/tightcode-0.3.17-darwin-x64.tar.gz"
    sha256 "833067283d0a80a073e0d3e06e075d2dd6c90d6d0dda8267560df6fcdb8c593f"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.17"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "398a96263928af64737d41a9e001875c931653edf3a7417d9d5e873668f0484b"
    sha256 cellar: :any_skip_relocation, big_sur: "6c39b8087219377964cc9e4e757e5001a0656aa5b6e1121efdfc74b42aaf96fc"
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
