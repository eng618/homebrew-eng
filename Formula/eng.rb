class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.16'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.16/eng_0.17.16_Darwin_x86_64.tar.gz'
    sha256 '440bb5db359c2701131e7a03f184f7afeecb0f58ce0582dc406f16edde2c4042'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.16/eng_0.17.16_Darwin_arm64.tar.gz'
    sha256 'cc53fe17c1f96cfaadf6c31d46d2505b3e6ed2200279f3f72ff202dbb3224d62'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.16/eng_0.17.16_Linux_x86_64.tar.gz'
      sha256 '2d618dec72452de2fb97e9c3dea7189f6f5e345a8f045947a0e28ae40e13718c'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.16/eng_0.17.16_Linux_arm64.tar.gz'
      sha256 'f7e0e51a22e1706e3223e66c3bca48204afbd1cf18436217ed00cbe62a58b462'
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
