# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.48"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.48/tightcode-0.3.48-darwin-arm64.tar.gz"
    sha256 "67660239cc8ed040ec0650c0df5a05b66cc74dcc88e9eac3453a0a664255dd63"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.48/tightcode-0.3.48-darwin-x64.tar.gz"
    sha256 "b11b80668bfee9d7a294d02fab563d14f290857af47ff70f278eed23fb3bf5d2"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.48"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ee16142bc1368214bda198400b067fefe40dce5f44bd312a984dffb2f601d650"
    sha256 cellar: :any_skip_relocation, big_sur: "8a0f6a8cc34b20ac415b069e952ad413deee29ee183ab72e61318bc98c0ffb95"
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
