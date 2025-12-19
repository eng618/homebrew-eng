class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.0/eng_0.29.0_Darwin_x86_64.tar.gz'
    sha256 '73040bac469ff84cfa2552ef88f9ef9aaf730a0c9767b30ffb6fedafccf1c39b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.0/eng_0.29.0_Darwin_arm64.tar.gz'
    sha256 '39b0304b7a9b134ec661a7bf2a632081e2c1a64ddd5bb79c8cecaf349302d30c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.0/eng_0.29.0_Linux_x86_64.tar.gz'
      sha256 '2cde894ca1f39c15f0658994942195839a904ea13b161fb4ab0491399fabe5cb'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.0/eng_0.29.0_Linux_arm64.tar.gz'
      sha256 'dc5158b9afae311428acceb9e2f2ac30f0cca669d5d53dad7822002622df20d0'
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
