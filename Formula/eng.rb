class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.11.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.11.3/eng_1.11.3_Darwin_x86_64.tar.gz'
    sha256 'eadcf6b780ad1f118fcb8a86b6736ba49ac7ae65b350c9386e8c8249bd38e487'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.11.3/eng_1.11.3_Darwin_arm64.tar.gz'
    sha256 '39a0a92971ddb62e6430b2d3ff3e8414a90eb2dd8a24b9ae885437ee5f3b8085'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.11.3/eng_1.11.3_Linux_x86_64.tar.gz'
      sha256 '5c96a46f915f6eea2d9a39cdf7cd95b136f22d8441c86210c2fe5488326f858c'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.11.3/eng_1.11.3_Linux_arm64.tar.gz'
      sha256 'df03c2967473fee022dfbb1eea77c292d6db83bd00053bbd46fbb3460bd76ece'
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
