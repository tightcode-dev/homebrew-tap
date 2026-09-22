# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.2"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.2/tightcode-0.3.2-darwin-arm64.tar.gz"
    sha256 "85573cdbbf8f4ceea2f3562a1016724a75da97ddd5589dec573934ed9aec23e6"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.2/tightcode-0.3.2-darwin-x64.tar.gz"
    sha256 "629ebaeb07f5f598e6e38b20928f0272ad4457b07bde30e855e2d8353d1c04d2"
  end

  depends_on :macos

  def install
    bin.install "tightcode"
  end

  def caveats
    <<~EOS
      First install: two steps finish the setup.
        tightcode login          sign in with the Google account you subscribed with
        tightcode install-hook   make git review every push on this Mac
      Upgrade: run `tightcode status` once, so the dashboard sees the new version now
      (Homebrew cannot tell it for you). Tight Code runs the review with Claude Code,
      which must be installed and signed in.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tightcode version").strip
  end
end
