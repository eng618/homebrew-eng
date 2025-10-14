class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.9'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.9/eng_0.25.9_Darwin_x86_64.tar.gz'
    sha256 '516893163914e4e72cfc028475c23e24551d82396998a21178a326ca67ce74ab'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.9/eng_0.25.9_Darwin_arm64.tar.gz'
    sha256 'ff0f905a051f642ec1ca35ec7c38ec1cccaa8334ad6b88571efc5586d91881c3'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.9/eng_0.25.9_Linux_x86_64.tar.gz'
      sha256 'ba81e3d42f681dd284e532a198cbb975b698bbea8af778ba4e1aa09fe304fa6c'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.9/eng_0.25.9_Linux_arm64.tar.gz'
      sha256 '5479b10cf8846f5b941f4c1c9fa3140315dcd8d688dfa5a4288af784b7c504a8'
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
