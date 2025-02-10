class Eng < Formula
  desc "Personal cli to help facilitate my normal workflow"
  homepage "https://github.com/eng618/homebrew-eng"
  url "https://github.com/eng618/eng/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "2e0df748693261740eb62d8ecc2d88af11c019ce107f38ab832556e1ea9fc085"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",  "-o", bin/"eng"

    # Install shell completions
    bash_completion.install "completion/eng.bash" => "eng"
    zsh_completion.install "completion/eng.zsh"   => "_eng"
    fish_completion.install "completion/eng.fish" => "eng.fish"
  end

  test do
    system "#{bin}/eng", "--version"
  end
end
