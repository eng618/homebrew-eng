class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.36.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.36.0/eng_1.36.0_Darwin_x86_64.tar.gz'
    sha256 '9eb1e873e6d0e79c54ddebff9e425cfe51e326b4bd60273eef469e58f227c8c6'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.36.0/eng_1.36.0_Darwin_arm64.tar.gz'
    sha256 'dcfacaa2cd0147f2b02b270af49f1f6c2b7d8793025d44f71c4b618b2650ba50'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.36.0/eng_1.36.0_Linux_x86_64.tar.gz'
      sha256 'b16d721c01ecda4b8c9061a773bd691df107b8b5a8393b7c1eb18c01b520355e'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.36.0/eng_1.36.0_Linux_arm64.tar.gz'
      sha256 '476959c89e8cddf9c174362ec9844a8fbfc3bdde1c5c278c2c84337fd54698a8'
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
