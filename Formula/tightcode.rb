# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.15"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.15/tightcode-0.3.15-darwin-arm64.tar.gz"
    sha256 "abe316ec5a49467d8bc42e90f7e4764d51516d296f14cc3b1a373f4cb93cfc78"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.15/tightcode-0.3.15-darwin-x64.tar.gz"
    sha256 "b4da5c2179fdc66711b695a12026c2511466486375015a5c5fed2fc5eb83fa43"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.15"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ca49faf44f16d7da26a1e49091f269efb9601125cde82eda61182fb9711b20d4"
    sha256 cellar: :any_skip_relocation, big_sur: "73026327df25a8445d89f0e904d4a39cb9313731c2b0ffd39992985c915a9e9d"
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
