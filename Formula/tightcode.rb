# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.42"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.42/tightcode-0.3.42-darwin-arm64.tar.gz"
    sha256 "72ecb08f36bbfe2bff7f9044311146424b83119ec5f91537106e2fd462b5725d"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.42/tightcode-0.3.42-darwin-x64.tar.gz"
    sha256 "fa227ef0cbf8f8e58ab5511739b27a960a05255381f1a84478f0e4ebad029dcc"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.42"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e65d73cf66c5d8e49606c698a8dc53bab48bc0feaef4fa48aa0cc83a1e442e3a"
    sha256 cellar: :any_skip_relocation, big_sur: "4eb0571905719f9b6fb84251ae9ac35199eef30e6194ef248aa8b6126cda1eea"
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
