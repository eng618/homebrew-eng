class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.14'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.14/eng_0.17.14_Darwin_x86_64.tar.gz'
    sha256 '57c322ffab05f1c5b5088ef95a92850c1f819ce5b00cb3c861cf4efe81af908f'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.14/eng_0.17.14_Darwin_arm64.tar.gz'
    sha256 'e94c9a8bb0333769295762edc651d23de34a2a1dddaae099cd834470e243bc81'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.14/eng_0.17.14_Linux_x86_64.tar.gz'
      sha256 '36a2b0fba3c621075ad9de648d3775066415ce1a00f95f93faab625bf0979750'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.14/eng_0.17.14_Linux_arm64.tar.gz'
      sha256 '5deca34fb934d4dac83a012507e2b5cfe62bc44d1091e28b01cd135e2bfe6fc5'
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
