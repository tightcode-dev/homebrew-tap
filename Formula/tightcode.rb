# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.39"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.39/tightcode-0.3.39-darwin-arm64.tar.gz"
    sha256 "b8ebf14543488d786c28be5f87cdea1128b5ddd3a4955bbc45dd6c9bc3929ffb"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.39/tightcode-0.3.39-darwin-x64.tar.gz"
    sha256 "6cfec153ca0b6f8fc6a11d9615f87c40678e53d329d331b653aeaf1e6dc7d2d5"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.39"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "da7ef95a9e5f21b5f3cf0c7b73c3a126a9575d3aa338eaf4cd0f3da30cba713a"
    sha256 cellar: :any_skip_relocation, big_sur: "b0464adb9b3afe277a6dc9f5407cb52d74b18d8eba8230e74c920e6079fa445e"
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
