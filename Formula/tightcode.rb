# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.3.62"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.62/tightcode-0.3.62-darwin-arm64.tar.gz"
    sha256 "7403674751266ffef6fe147396e0644705b39cdaf4b16d87d30c2e5b1e60d24c"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.62/tightcode-0.3.62-darwin-x64.tar.gz"
    sha256 "98ea659cf6fec2e8eb8a9afcb3e19ac639c4b174f4ead4962c2932e84d7dbb4a"
  end

  bottle do
    root_url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.3.62"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "26117bee1f9d3879379b4312813536d526ec5aee97e56033181ab682ef4c2899"
    sha256 cellar: :any_skip_relocation, big_sur: "264d762daf3c06fa176973be8b9fb56cbe224ce516bb23753599111a445bf7a6"
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
