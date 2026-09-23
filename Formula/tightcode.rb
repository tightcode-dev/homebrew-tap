# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.14"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.14/tightcode-0.3.14-darwin-arm64.tar.gz"
    sha256 "33f75620a1a84e3e1d112a2272c3482badda8105bc385823bc281193691b2b6b"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.14/tightcode-0.3.14-darwin-x64.tar.gz"
    sha256 "2ae70bf04e41b255f871bc92e1daad0bd0440bb51d71230070867f963940409b"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.14"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0759d09c851a7f4ee59e6007e9040761b7d27f11449c3f406d4b3953cfe946cd"
    sha256 cellar: :any_skip_relocation, big_sur: "db4aeeb7db98f820df217f2f61b83c85cd7975e2765a9504ab31e25b7ae9cc3d"
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
