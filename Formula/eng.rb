class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.32.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.32.0/eng_1.32.0_Darwin_x86_64.tar.gz'
    sha256 '6b99cd5b1ff853556ab83c51623d088685eb3d17eeab9d0c2d1f8e06e81dc0b9'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.32.0/eng_1.32.0_Darwin_arm64.tar.gz'
    sha256 '18ac85010b31b1fe96b97cc9cbcd43305236942ff99539c18bdfae230a334e0a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.32.0/eng_1.32.0_Linux_x86_64.tar.gz'
      sha256 '5aedd0169134d167be870ad75be40755f5fcb6b31a15ab163c46391b65a4a239'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.32.0/eng_1.32.0_Linux_arm64.tar.gz'
      sha256 '1d1fe1cec85ec7f9dc15ab9a33a27990ed6df9ef5914b9a71920edd623b6bb96'
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
