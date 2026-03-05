class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.8.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.8.3/eng_1.8.3_Darwin_x86_64.tar.gz'
    sha256 '54111d1adc8aace426460debbdf101ea492b5a2d2ba0f95e5f6c50c6ff524ab5'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.8.3/eng_1.8.3_Darwin_arm64.tar.gz'
    sha256 '59424ad6719b1325ecc178c64601a19227d0eba4245984ba0ccbe75d141f055b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.8.3/eng_1.8.3_Linux_x86_64.tar.gz'
      sha256 'af901cd2f0a8ee5bf52fd1d3436acf3354c985a1f5d0f55375584a475963ca94'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.8.3/eng_1.8.3_Linux_arm64.tar.gz'
      sha256 '93d0f1de2454622bcf823eda8e55b000926ac519f002b3bdc44e2a94029d2897'
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
