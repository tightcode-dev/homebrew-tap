# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.54"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.54/tightcode-0.3.54-darwin-arm64.tar.gz"
    sha256 "6458792ec3804b28df8b155b422dbcf03e219b295c71c277533fcc266a8acfe1"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.54/tightcode-0.3.54-darwin-x64.tar.gz"
    sha256 "f342f06bf7db4d214620fc7362af7e7461ae9f40fd631c8e57656bae047d4206"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.54"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bfdfb5c35b2786a8796f0f53c108f13071ec10ecd890db599c68112808354622"
    sha256 cellar: :any_skip_relocation, big_sur: "46facaa4e37d62f903c2f3ea34d4b2a902aa007e6e7999fe4bcab84956231336"
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
