# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.50"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.50/tightcode-0.3.50-darwin-arm64.tar.gz"
    sha256 "52568088dad2a96b2c2f0909cac9e9a3e6cf41bd306ca30edfb985f282bf894a"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.50/tightcode-0.3.50-darwin-x64.tar.gz"
    sha256 "1b51bd750f611f9580983115c296df537e13e8741cacf60fc49e1a411f357d01"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.50"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5c250f22e77bb88fc9e5af515d1d924cdb71c4f62a9d8084e73db2ffa0212f0c"
    sha256 cellar: :any_skip_relocation, big_sur: "80966196335e9fb59ca38a4388671eb7d2558a9bd7bcdaddee91521b7ca3cca8"
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
