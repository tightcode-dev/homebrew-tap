# typed: strict
# frozen_string_literal: true

# Written by scripts/release.mjs in the (private) source repository. Do not edit by hand.
class Tightcode < Formula
  desc "AI code review on every git push"
  homepage "https://tightcode.dev"
  version "0.2.1"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.2.1/tightcode-0.2.1-darwin-arm64.tar.gz"
    sha256 "56ae0423c32944c00d6c2b572a86e37d61076d240cec5e7fa01876311cbcc0bd"
  else
    url "https://github.com/tightcode-dev/homebrew-tap/releases/download/v0.2.1/tightcode-0.2.1-darwin-x64.tar.gz"
    sha256 "5b178f348c40eb877fb69783875f5a9dbe72de300de7e848556a271add6ea930"
  end

  depends_on :macos

  def install
    bin.install "tightcode"
  end

  def caveats
    <<~EOS
      Two steps finish the setup:
        tightcode login          sign in with the Google account you subscribed with
        tightcode install-hook   make git review every push on this Mac
      Tight Code runs the review with Claude Code, which must be installed and signed in.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tightcode version").strip
  end
end
