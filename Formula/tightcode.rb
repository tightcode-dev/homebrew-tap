# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.28"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.28/tightcode-0.3.28-darwin-arm64.tar.gz"
    sha256 "31b305fb4a63116ba4595bbcddb9ca9290c8175556af313e579d27cfb8f8699c"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.28/tightcode-0.3.28-darwin-x64.tar.gz"
    sha256 "cdd634b955e9caac0fa86122bf347dac900ff8bf98865fc512c4c92f51137dd4"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.28"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "64b9fe7eba8afeadeb8585d5c260694b881f8c21c1c4f5adaa6bd8c6218b093e"
    sha256 cellar: :any_skip_relocation, big_sur: "e65e165ff4f105052721fba5c693a89d422edd35a998d92785699b86dc4b8390"
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
