# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.10"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.10/tightcode-0.3.10-darwin-arm64.tar.gz"
    sha256 "e5db6e66af9463a554d51bf151932ecce23566053706d99f968250b80f17ff89"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.10/tightcode-0.3.10-darwin-x64.tar.gz"
    sha256 "9c5bfa11eb790c1ec9bcd81e8838acf0a5421a2dc520c1372900b4bff5083eab"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.10"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8336bcd450b3ffda39473a5b2db6abc1e93e4358391a9ff1d4c1a9c6883655b3"
    sha256 cellar: :any_skip_relocation, big_sur: "e94758b4c3b89b6eb5d319bf8c17f371e042c229b4dafa8c62a3e4c6aa21470e"
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
