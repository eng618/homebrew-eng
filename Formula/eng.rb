class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.0/eng_0.28.0_Darwin_x86_64.tar.gz'
    sha256 '53e6d6a3d4f782dbc7ac3d9915f68f067996c8135346d9ae4956e97ea9c745a7'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.0/eng_0.28.0_Darwin_arm64.tar.gz'
    sha256 'a6b2f59e06c650f6213d3b7ad7ae521d86ae3677377fe166cc9681acf501c947'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.0/eng_0.28.0_Linux_x86_64.tar.gz'
      sha256 '47265930e5e6b488797eae329bdc74be7f6635dd01616b5b25824ab5ccfe76c9'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.0/eng_0.28.0_Linux_arm64.tar.gz'
      sha256 '31fa7f55d69a55a0928e34ea0b7625a215c861536e8b29ae3e781123871dc3ca'
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
