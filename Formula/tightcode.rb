# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.12"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.12/tightcode-0.3.12-darwin-arm64.tar.gz"
    sha256 "607c890f0132b0cf7608ec32ca9d0ce30e744b9399649af985a2b9cb274f79c8"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.12/tightcode-0.3.12-darwin-x64.tar.gz"
    sha256 "d578d9e7c9218a638d42a5c9c51028d593aa54c278682f247a33c9ed8f473b80"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.12"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a6afe17288691df5b62f6e8c5109a13c977bce7084f48c7a18f76f61bc2b588b"
    sha256 cellar: :any_skip_relocation, big_sur: "094ee979f748539613c4ec319cb8d15e07dce47441320e42dc3f3d7dbf413ef3"
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
