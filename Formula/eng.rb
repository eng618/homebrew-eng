class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.1/eng_0.19.1_Darwin_x86_64.tar.gz'
    sha256 'f92d2483081af6ed235d0144aa778a8a78bca58fa1685c990738b6ed62e1e99b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.1/eng_0.19.1_Darwin_arm64.tar.gz'
    sha256 '232c2e1802f40c4c154c2ad4c2ad0b7c4a3013dd12b925f837e18e81075a5e48'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.1/eng_0.19.1_Linux_x86_64.tar.gz'
      sha256 '8f33b75898e78f4311a6d7dbbd7c849f71c3b8731f42636ed300bbdae98b81e1'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.1/eng_0.19.1_Linux_arm64.tar.gz'
      sha256 'ce11ad5c6a6ca9ce1a3be76ed9bdbb785c010d5a53611322efcfd6bae5f01edc'
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
