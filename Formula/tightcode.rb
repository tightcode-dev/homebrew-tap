# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.30"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.30/tightcode-0.3.30-darwin-arm64.tar.gz"
    sha256 "42afb78ecbca122c2b000a5b844296f140cd312a9ee66f82d55c5b7852bd7e44"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.30/tightcode-0.3.30-darwin-x64.tar.gz"
    sha256 "122ef2bb4fd4e388e8a085c502ec0a168215664de5ca68eb9de1b717b0367067"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.30"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7a888e11a6f1c62b19a1fcdd1b57a59de4860da4605c5a67d6b78d06d9535519"
    sha256 cellar: :any_skip_relocation, big_sur: "fb3faeaee9e0f0151f267b9788d1eb58c93c1253de04a791c5f4569f846ded84"
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
