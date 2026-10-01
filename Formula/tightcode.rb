# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.31"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.31/tightcode-0.3.31-darwin-arm64.tar.gz"
    sha256 "13266b427acc3bcf06b3b88e70342b9c47e1c512f9eba1885c3729aea114e349"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.31/tightcode-0.3.31-darwin-x64.tar.gz"
    sha256 "6cd9b455390f7fd3f3529054a04a7b74ab20f30c16013c9a7f208adfba3f09ac"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.31"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "939583e5a5ad53bd82b2eb8cbeef0f5d88818ae12b200e4ff5c6568ee8c7c7c5"
    sha256 cellar: :any_skip_relocation, big_sur: "ad3fb78fba7558fa19f4e8f9ba4df321e67b7b6e9455e8741356e5f9cf83639f"
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
