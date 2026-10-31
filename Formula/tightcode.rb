# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.55"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.55/tightcode-0.3.55-darwin-arm64.tar.gz"
    sha256 "592d6cf1b5cfd67330300b8358c32f1d26f5b1f3a72e293bdba2d384f092f4eb"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.55/tightcode-0.3.55-darwin-x64.tar.gz"
    sha256 "e3987bb5f4f2dbe5ca74344fccdbec36de65d54b6b57e95da4d5b4320df60149"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.55"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "78bffb9eb02d5b8ca646b133876fa951c5486410cefdb76b93ca9ea35e3fd0cc"
    sha256 cellar: :any_skip_relocation, big_sur: "ef2026fc00fa9928cb9d97840d54842107353924183fdebb0eea1f184b2fee51"
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
