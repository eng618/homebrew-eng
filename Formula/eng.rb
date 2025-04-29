class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.20'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.20/eng_0.17.20_Darwin_x86_64.tar.gz'
    sha256 '5b1296008dfe7fce6d659ee178bd54e9dfd9db4c470786e89c8fbe2949683de7'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.20/eng_0.17.20_Darwin_arm64.tar.gz'
    sha256 '58dd0caf9f22e2314f4244c5d2db5f0524f1cb15ea450ac189f640fa9a2abb52'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.20/eng_0.17.20_Linux_x86_64.tar.gz'
      sha256 '8fb12b92ee030c346fad2f75807c691f3d5ffd29b7de9354aa9db10ff4c1b122'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.20/eng_0.17.20_Linux_arm64.tar.gz'
      sha256 'f551bee42fa9d00ffeeea4003516227ccbed3bfa24d7d6083650fec82cad1780'
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
