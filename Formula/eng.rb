class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  if OS.mac?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.15.12/eng_Darwin_x86_64.tar.gz'
      sha256 '587db12c17ddd44368c943ba131eb1857fd974852c3d163613a93bf4c66e167d'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.15.12/eng_Darwin_arm64.tar.gz'
      sha256 '13426cf12bdeceb061fc1fa807272443247b377f6ffb477b12ca0c7efb3a2f9f'
    end
  elsif OS.linux?
    url 'https://github.com/eng618/eng/releases/download/v0.15.12/eng_Linux_arm64.tar.gz'
    sha256 '81f0c46a7dbae84ba95c8e38550b8c841516cf0ac1157a2ce384b9cba2f8ab83'
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
