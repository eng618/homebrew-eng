class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  if OS.mac?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.16.11/eng_Darwin_x86_64.tar.gz'
      sha256 '0a9a34210e688a5e9afab036f5971ec41ca14aae4c8b5b1670ef18c022af9eed'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.16.11/eng_Darwin_arm64.tar.gz'
      sha256 '3baa14a9023ce35302932dd3f70d62193a771b3a175335682b4dc668af187507'
    end
  elsif OS.linux?
    url 'https://github.com/eng618/eng/releases/download/v0.16.11/eng_Linux_arm64.tar.gz'
      sha256 '039298140cf9733cc70d37da9b79cfbba99e624a04e7f4935fa6c90e4a4bd162'
  end
  license 'MIT'


  def install
    bin.install 'eng'

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
