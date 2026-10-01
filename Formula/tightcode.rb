# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.32"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.32/tightcode-0.3.32-darwin-arm64.tar.gz"
    sha256 "e77985d18b38aaf38225ff749deb21093449ea20cb8e8f29b9894aee924b5ef4"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.32/tightcode-0.3.32-darwin-x64.tar.gz"
    sha256 "2a493e7e114244077a4686a8d84992f38b01d72bfc4ed23734be7f5818b886af"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.32"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "72e5a92677781af782c09f23d77bde02dea7a85102689f640b44165986101381"
    sha256 cellar: :any_skip_relocation, big_sur: "fe153e61040715ece49c38402908076827d6b5117f619bf7670efbb299fc7544"
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
