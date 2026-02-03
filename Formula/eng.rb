class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.3.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.3.5/eng_1.3.5_Darwin_x86_64.tar.gz'
    sha256 'bfaeb3173fb2394eaeb98fc5aaee4d30cba8bb44abf26c31ed4b8020b0748968'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.3.5/eng_1.3.5_Darwin_arm64.tar.gz'
    sha256 'dbde0d33f0ba322a3b5f265e9ff4410e76fd245c2382d470313b765355d7cf04'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.3.5/eng_1.3.5_Linux_x86_64.tar.gz'
      sha256 '0239270ebe19ef52029f07669ae699c1df3fb32861a6258b9452c67ca32c5c2c'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.3.5/eng_1.3.5_Linux_arm64.tar.gz'
      sha256 '3a5ddfb8e2621f8f189b1648e36605718a34874fa9306ecb5a7d0f18ca95dd9c'
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
