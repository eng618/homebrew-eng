class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.21.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.21.0/eng_1.21.0_Darwin_x86_64.tar.gz'
    sha256 'c727ad4f8b59ddf20526383158b9520055354a1ba1d04ad1734d328ebdd40b0b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.21.0/eng_1.21.0_Darwin_arm64.tar.gz'
    sha256 '3a61d7e0c4628d76b6e2356f3cc434fc0ac974c1cc0145965c624f8f3ba3dd85'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.21.0/eng_1.21.0_Linux_x86_64.tar.gz'
      sha256 '850a6c0eef7b4a40c2064c31f6d54a5b0d441215f2ea83a23bd70ad2f127e321'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.21.0/eng_1.21.0_Linux_arm64.tar.gz'
      sha256 'cf17d132b5638db248114ac4645557e4b872d5143b278f887cfc393360d61d0b'
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
