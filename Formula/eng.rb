class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.1/eng_Darwin_x86_64.tar.gz'
    sha256 'ca1b4e8c841d3f1cea83f9244b2590fbb3d0f0cf6ae33df77234d50f04194929'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.1/eng_Darwin_arm64.tar.gz'
    sha256 '3d23197063f46c0e555f4ff5072bb133982b135ea242ca93a88aaa9a3e4e81be'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.1/eng_Linux_x86_64.tar.gz'
      sha256 '3ec0a86b6b81e07fd1429e6605c3ec0863b185fbb9ff1c42d43dd6c82ed5259c'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.1/eng_Linux_arm64.tar.gz'
      sha256 '20e63b2e63b54fbe7d28ce3b50fe51e3674ebb83a4e320d4bfa35eed46b3113e'
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
