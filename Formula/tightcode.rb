# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.26"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.26/tightcode-0.3.26-darwin-arm64.tar.gz"
    sha256 "daf10b0ee1b3c9828924e9bd77d0b0caf14d146de5ad227a7b747a2ae6b6fc28"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.26/tightcode-0.3.26-darwin-x64.tar.gz"
    sha256 "ffae829f3bf2f5044b17ad0d95ea956c41f72b9a5a4741c38b919453010bb3c7"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.26"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cad655f1f4f03149890b5c493be432aa0a84dfa04480a14599adef850d9aec10"
    sha256 cellar: :any_skip_relocation, big_sur: "cb130851c60d7cbb6084fa37a39ab5939bb89a67f4cc0aaa051aa24a9f9c2524"
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
