# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.3"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.3/tightcode-0.3.3-darwin-arm64.tar.gz"
    sha256 "707225e878f76ce1d73237006c07f33329d208ba392473c614e05582e66a37bf"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.3/tightcode-0.3.3-darwin-x64.tar.gz"
    sha256 "d47de891dd6cb49958a8d401e3069897d3d550f2060998d6a34402d73348c8ca"
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
