class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  if OS.mac?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.15.6/eng_Darwin_x86_64.tar.gz'
      sha256 ''
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.15.6/eng_Darwin_arm64.tar.gz'
      sha256 ''
    end
  elsif OS.linux?
    url 'https://github.com/eng618/eng/releases/download/v0.15.6/eng_Linux_arm64.tar.gz'
    sha256 ''
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
