class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.21.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.21.3/eng_0.21.3_Darwin_x86_64.tar.gz'
    sha256 'edcc69d3e7daa181fa61635de25af3736340ea63a0f0149763af7ac8085a69c7'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.21.3/eng_0.21.3_Darwin_arm64.tar.gz'
    sha256 '2128190cfd5cf7b8f135a392d6d3aa953bccd092a4288be3e14c1c6262095df2'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.21.3/eng_0.21.3_Linux_x86_64.tar.gz'
      sha256 '0b4040cf1b32b72d47b4ba57593934bf86d4ff37f7e7f8bf0aaa80cca293e619'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.21.3/eng_0.21.3_Linux_arm64.tar.gz'
      sha256 '9042c87447fbaae750d25852fbb5f840d13d8b40149384238ba3cdf2d4588afc'
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
