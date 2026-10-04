# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.43"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.43/tightcode-0.3.43-darwin-arm64.tar.gz"
    sha256 "1d3a38a198425604a8e6d3bc04db5bc4b7cbba084969ac1de2152253f084fb65"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.43/tightcode-0.3.43-darwin-x64.tar.gz"
    sha256 "72b165f5a428798d0e34cfe864b6ff798188e767993d0faef982402ed0d7002a"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.43"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6af68ad8068a40ed0cd46d91a15c43025d5af606c4828dd08d68a5d6444d6ba1"
    sha256 cellar: :any_skip_relocation, big_sur: "79a24fc95b21453ea50a97801dc98cbc6822c9a3e2d01973af04007340c6f5dc"
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
