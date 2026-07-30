class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.30.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.30.0/eng_1.30.0_Darwin_x86_64.tar.gz'
    sha256 '15960d893df827e585c03af9fc2c55b1f0a3f18f73ecdcf206a80599889b6770'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.30.0/eng_1.30.0_Darwin_arm64.tar.gz'
    sha256 'ff824a25edb6bab709d53da23e6d6f576ed30f380d5816b3bd1c1af47064040b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.30.0/eng_1.30.0_Linux_x86_64.tar.gz'
      sha256 'de74433a2eb9fd9e9d4bab92fd4b62664674d8a3a51a8537157673c1ffd270b4'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.30.0/eng_1.30.0_Linux_arm64.tar.gz'
      sha256 '58426cccdb295852bb2cf93ec69925e5935c4fc7a5e0ee6892f5da8e7ba44de5'
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
