class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.13'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.13/eng_0.25.13_Darwin_x86_64.tar.gz'
    sha256 'b66eae36f1d83542409fbb75f3951397c5ac1aa20c34e4a455fb5a27c24acb82'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.13/eng_0.25.13_Darwin_arm64.tar.gz'
    sha256 '6407be16b51f1a00266847bb3389eaaa3e8ba61b18fd1856606fffb08e259f18'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.13/eng_0.25.13_Linux_x86_64.tar.gz'
      sha256 '1835153da9749d4892101e0ad3b70fe3515d4fcb9a8583e28ccdcf0e8aa36f52'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.13/eng_0.25.13_Linux_arm64.tar.gz'
      sha256 'e9eb25d4e8553b5866fc0d9b9c0588536ca2fe5da96cd75d9bff770f726a561f'
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
