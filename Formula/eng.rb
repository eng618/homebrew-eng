class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.2/eng_0.25.2_Darwin_x86_64.tar.gz'
    sha256 '7421dcb2bf2c19cbaf3244a8ba9d899185975b8ab2fc2b654afff8ca6516daae'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.2/eng_0.25.2_Darwin_arm64.tar.gz'
    sha256 '7da8def0a3e5240c165051d37f1b5554023ca7216bd20d44f3f464c58df39725'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.2/eng_0.25.2_Linux_x86_64.tar.gz'
      sha256 '0f3eeb2363f61c9ce0c7a16f165d2ddb7bf04eeddfea174d3ae8934579339068'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.2/eng_0.25.2_Linux_arm64.tar.gz'
      sha256 '226de45a4576b6cc04f7cd88b1ea05227de7c06bc53e9fb41dfb100be649339b'
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
