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
    generate_completions
  end

  def generate_completions
    (bash_completion/"eng").write Utils.safe_popen_read("#{bin}/eng", "completion", "bash")
    (zsh_completion/"_eng").write Utils.safe_popen_read("#{bin}/eng", "completion", "zsh")
    (fish_completion/"eng.fish").write Utils.safe_popen_read("#{bin}/eng", "completion", "fish")
  end

  test do
    system "#{bin}/eng", "--version"
  end
end
