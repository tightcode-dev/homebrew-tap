# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.36"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.36/tightcode-0.3.36-darwin-arm64.tar.gz"
    sha256 "4cc0b2c90b8a0e276bd29e94391d3163569c46bb611373532667db4afba94a64"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.36/tightcode-0.3.36-darwin-x64.tar.gz"
    sha256 "3cebe46c6c04bbaeefe07c7665c850289b405d1b5afc3ffae6026757b7b3f08c"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.36"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dede6ab570f24a4a8618b898ef8d8a101b550d1d8e0c2682f7d78f6ca3566632"
    sha256 cellar: :any_skip_relocation, big_sur: "dcd6b1d24965ea281c1dc7fd640d99722532ed7fbb5fd6aaa6637088b456d248"
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
