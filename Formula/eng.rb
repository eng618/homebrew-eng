class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.23.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.23.0/eng_0.23.0_Darwin_x86_64.tar.gz'
    sha256 'f931981afa06fa24fcaf405f8f277918022b5f766f52953987b6c0dc60aab4ca'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.23.0/eng_0.23.0_Darwin_arm64.tar.gz'
    sha256 'cc9275f50c48b19cd43ce0b9d12bd5a706866678ddaa531a93061acc65e3c7ee'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.23.0/eng_0.23.0_Linux_x86_64.tar.gz'
      sha256 '2a11c8867bee5c8a39c2276516f387f97242f5adf8a301fdb86792bdeed06b36'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.23.0/eng_0.23.0_Linux_arm64.tar.gz'
      sha256 '94e0b995fd6ea90affb4a239c38e216e7a4c4d657ad813592988bd8d2cf26b3d'
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
