# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.22"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.22/tightcode-0.3.22-darwin-arm64.tar.gz"
    sha256 "40faa04fa3c84b0a879b032770bd693eeb9095893860b853eeee5de2faae2b41"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.22/tightcode-0.3.22-darwin-x64.tar.gz"
    sha256 "f9e530dcef4b66de40ad88fae6437f5aebd496722cf9aa16ee85b76bacde2d78"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.22"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c5c104bfe08fd6bfe164ac52a15f298c68d595e87ba7aa4c48d3ee38af95bc1e"
    sha256 cellar: :any_skip_relocation, big_sur: "04545875ce2beb040a0eacf599b7f5f448a6900bb5e5f82bc60e47554eae1e17"
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
