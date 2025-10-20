class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.10'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.10/eng_0.25.10_Darwin_x86_64.tar.gz'
    sha256 '18759edab23e4d86780bd5f3bd2d5d5f5b8a0d941a97d8a5548e4f354aff2d8d'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.10/eng_0.25.10_Darwin_arm64.tar.gz'
    sha256 'eaf03d0875267d5fe071ad9864c685873693b432aa4c415d640768d1d2058853'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.10/eng_0.25.10_Linux_x86_64.tar.gz'
      sha256 'c6fc86df2ccadfdf544db6a55a7770965540a0dfe8f4b4f2063b09d5786cb7e6'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.10/eng_0.25.10_Linux_arm64.tar.gz'
      sha256 '22e6f14fd511ed6c242cd1f651929ee336d844963fe100f22c8704c197e2a6da'
    end
  end
  license 'MIT'

  def install
    puts "bin: #{bin}"
    puts "Installing eng to: #{bin}"
    bin.install 'eng'
    puts "eng installed successfully"
    puts "Permissions of eng: #{File.stat("#{bin}/eng").mode.to_s(8)}"
    # Verify the binary is functional before generating completions
    system "#{bin}/eng", '--help'
    generate_completions
  end

  def generate_completions
    puts "PATH: #{ENV['PATH']}"
    puts "Running: #{bin}/eng completion bash"
    (bash_completion/'eng').write Utils.safe_popen_read("#{bin}/eng", 'completion', 'bash')
    (zsh_completion/'_eng').write Utils.safe_popen_read("#{bin}/eng", 'completion', 'zsh')
    (fish_completion/'eng.fish').write Utils.safe_popen_read("#{bin}/eng", 'completion', 'fish')
  end

  test do
    system "#{bin}/eng", '--help'
  end
end
