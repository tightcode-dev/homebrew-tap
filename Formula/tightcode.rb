# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.38"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.38/tightcode-0.3.38-darwin-arm64.tar.gz"
    sha256 "7e247ade1bba27b0431087a35e896926a70c40f4d25ca0e6cfa158630f172837"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.38/tightcode-0.3.38-darwin-x64.tar.gz"
    sha256 "dc509e3083997d12de4c293534cef18594fe51a659482090e747b376ca7686e7"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.38"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "69f5ac19e0752f4d5e49baa8c3da643f3c0635a32adf0490110911589c4925ff"
    sha256 cellar: :any_skip_relocation, big_sur: "8f65f4a5fbcf5fc744dc5b05380f7aa73317888693d65355f27cb61800d99172"
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
