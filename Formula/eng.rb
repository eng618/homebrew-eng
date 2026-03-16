class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.11.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.11.0/eng_1.11.0_Darwin_x86_64.tar.gz'
    sha256 '3a4fb0ede9ed8660dde1d5960de4bf0876a523693cd6f85017cab9b65f2f088a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.11.0/eng_1.11.0_Darwin_arm64.tar.gz'
    sha256 'dbfe58488eaef620b833989e3553ede5af63663416b3b0b4a4437104806d9b38'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.11.0/eng_1.11.0_Linux_x86_64.tar.gz'
      sha256 'f225030f9d81f83a8c59b56e61a6441293f3c96a5c0470a101da7c59d94577d3'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.11.0/eng_1.11.0_Linux_arm64.tar.gz'
      sha256 '74ea1ece4af40105633e92b84bd9bb349e108075f92892ca3d17b88c2301b86f'
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
