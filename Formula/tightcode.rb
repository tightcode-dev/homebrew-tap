# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.47"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.47/tightcode-0.3.47-darwin-arm64.tar.gz"
    sha256 "fd65cf1eb90b765c7294fda001db6f98317c6de219cd0bc2459fef34d073cc42"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.47/tightcode-0.3.47-darwin-x64.tar.gz"
    sha256 "7376e88d2b4efc4b8eb93a05d33abb340b6fd86b3f61d46726bef575225499ee"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.47"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5f85a28ad542fcebe7371b89dc1830b1ff3f8edfe992eaeb0c3e00020018d340"
    sha256 cellar: :any_skip_relocation, big_sur: "0d95652e6b81a5ab216092ad7d4d07199353455f1e647a6eb4eee2758dd743c9"
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
