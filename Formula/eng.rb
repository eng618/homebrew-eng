class Eng < Formula
  desc "Personal cli to help facilitate my normal workflow"
  homepage "https://github.com/eng618/homebrew-eng"
  url "https://github.com/eng618/eng/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "2e0df748693261740eb62d8ecc2d88af11c019ce107f38ab832556e1ea9fc085"
  license "MIT"

  def install
    system "go", "build",  "-o", bin/"eng"
  end

  test do
    system bin/"eng", "--help"
  end
end
