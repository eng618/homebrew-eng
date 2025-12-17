class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.2/eng_0.28.2_Darwin_x86_64.tar.gz'
    sha256 '603537a1c03ecf1633a7d009fc6089b45faf1545dfa03db4aca5820e707e494d'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.2/eng_0.28.2_Darwin_arm64.tar.gz'
    sha256 '6b3924edc8d84f6d3bd0748f14f40dedfdade3a583e0c9f00cbd54097b711e62'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.2/eng_0.28.2_Linux_x86_64.tar.gz'
      sha256 'e2b69b2b71ff984d83e97500dfb30f0155bc5a1c52139ed114f67cf167493a7f'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.2/eng_0.28.2_Linux_arm64.tar.gz'
      sha256 'b0367f566694969043aae151dae7036eb30aac806831ed1528027b062ee00c61'
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
