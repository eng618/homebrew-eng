class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  if OS.mac?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.15.13/eng_Darwin_x86_64.tar.gz'
      sha256 'c284f1b7690682e61e733047f3e5a87f7a552e8ab3c5dc35a45a1ea68a0bb847'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.15.13/eng_Darwin_arm64.tar.gz'
      sha256 'f92681ecbd3bec781bd3ae97bac419072f001d1ec1fc77affc236428d621f9f2'
    end
  elsif OS.linux?
    url 'https://github.com/eng618/eng/releases/download/v0.15.13/eng_Linux_arm64.tar.gz'
    sha256 '9ec0ae517e490f24d4c530481bb32335f36a4e020fabce8ab4f62e1303cfe8b5'
  end
  license 'MIT'

  depends_on 'go' => :build

  def install
    system 'go', 'build', '-o', bin/'eng'

    # Install shell completions
    generate_completions
  end

  def generate_completions
    (bash_completion/'eng').write Utils.safe_popen_read('#{bin}/eng', 'completion', 'bash')
    (zsh_completion/'_eng').write Utils.safe_popen_read('#{bin}/eng', 'completion', 'zsh')
    (fish_completion/'eng.fish').write Utils.safe_popen_read('#{bin}/eng', 'completion', 'fish')
  end

  test do
    system '#{bin}/eng', '--help'
  end
end
