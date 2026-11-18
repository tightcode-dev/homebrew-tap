# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.61"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.61/tightcode-0.3.61-darwin-arm64.tar.gz"
    sha256 "0cc8017a89745cdcaa9d6281ae856d3d66b8878526902fe18259c6308f1e6bda"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.61/tightcode-0.3.61-darwin-x64.tar.gz"
    sha256 "e4295586c3a054889df330adb96508668a93ecbd06ba17d7381bcf1ea6a0ea8c"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.61"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "72f0531cdbff214ffcc98fbd6a2cea3750ef0fb1848722de528c33f0d2bc3480"
    sha256 cellar: :any_skip_relocation, big_sur: "c2ba31dae3f14e7de006fe6979332100e9a406168d2fa6f3ea9a4d63ef3370f2"
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
