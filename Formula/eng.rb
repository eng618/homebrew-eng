class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.18.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.18.0/eng_1.18.0_Darwin_x86_64.tar.gz'
    sha256 '66597ad181758e1defafc1dd2e12851729bf2e2c87f9b844cacd793c6a2ebe15'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.18.0/eng_1.18.0_Darwin_arm64.tar.gz'
    sha256 '9c5e0d7ce5ba5641a369fb21f1f9d5af792d6356cb1c06fbe0dc0200bb148639'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.18.0/eng_1.18.0_Linux_x86_64.tar.gz'
      sha256 '1576eebaa8bd9b795b36e8f517961f1d4bbd5b8f2482bba1b8f56f24cc70e8b5'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.18.0/eng_1.18.0_Linux_arm64.tar.gz'
      sha256 'fdd57a820eac3f3100cc5f6cafcc95f87ef9fe2abe6b3f58a9b1632f8115d5f6'
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
