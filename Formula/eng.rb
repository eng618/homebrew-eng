class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.27.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.27.0/eng_0.27.0_Darwin_x86_64.tar.gz'
    sha256 '5dee9ba5c0a54424c09c0485e5da3f83a344c0f95845ea869dfd9b6ec6eba908'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.27.0/eng_0.27.0_Darwin_arm64.tar.gz'
    sha256 '526e9f6dea1a39c527bef608277c9359873a21b0140e450756ccef15c2882f91'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.27.0/eng_0.27.0_Linux_x86_64.tar.gz'
      sha256 '03ef56593f7284a06e809d22dc64b108c86e9fa436d915018368dd52f2a1a872'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.27.0/eng_0.27.0_Linux_arm64.tar.gz'
      sha256 'cccd6e4af75e2478e6fc96b75923a7a70791840009a24074a1671b4af3a55707'
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
