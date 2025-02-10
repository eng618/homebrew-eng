class Eng < Formula
  desc "Personal cli to help facilitate my normal workflow"
  homepage "https://github.com/eng618/homebrew-eng"
  url "https://github.com/eng618/eng/archive/refs/tags/v0.14.3.tar.gz"
  sha256 "6aa7a1e75b6279a2ad8b0795870d973182d0641b20caae747334a554884956cf"
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
