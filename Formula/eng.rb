class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.23.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.23.0/eng_1.23.0_Darwin_x86_64.tar.gz'
    sha256 'c64ab26b185d8f1d9c7dcf76bd287045f5a64711a6e3908f0e932abccdc16863'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.23.0/eng_1.23.0_Darwin_arm64.tar.gz'
    sha256 '570f59facb7c7bcd5ea4d2b0740c9d02b6b51e593fe38e51377bcdc2df37860a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.23.0/eng_1.23.0_Linux_x86_64.tar.gz'
      sha256 '47b99d708c86873463ad6eb99c33a9a5917e2d3ad544692b7fcf51ac1992f3da'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.23.0/eng_1.23.0_Linux_arm64.tar.gz'
      sha256 '3c6ae3f641e6362b01af3dca2673c6ece8abe5eb4a27cd8c758dfabaa4b953a8'
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
