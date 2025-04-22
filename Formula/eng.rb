class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.8'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.8/eng_0.17.8_Darwin_x86_64.tar.gz'
    sha256 '54e44efba1c4d48b175c0263a4e7fd5fea2db852b49bda024bf6f4d6efbdce5c'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.8/eng_0.17.8_Darwin_arm64.tar.gz'
    sha256 '01f01e9d580e6f8504fbb5b49508121b609d138618449aafe589a194dd4c3508'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.8/eng_0.17.8_Linux_x86_64.tar.gz'
      sha256 '854dcac7df5bde5e66b019b7b9231364802e985f1dd7a8bf0bd808b70de38c75'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.8/eng_0.17.8_Linux_arm64.tar.gz'
      sha256 '6fd3dc8ba98433403e53032fecacc00f2850bcaa1dc7de4f0fc58fe25d9fe135'
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
