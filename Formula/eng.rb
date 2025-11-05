class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.3/eng_0.26.3_Darwin_x86_64.tar.gz'
    sha256 '89bbc2731ab1a6bef33ca077c38c1e4f02fd21f34ac7e983af25cb9597ce13f0'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.3/eng_0.26.3_Darwin_arm64.tar.gz'
    sha256 'ccd1193bb152fe0a539cc0aadfb78bc676eead7181e98b1b1e4e58e01fa40fb2'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.3/eng_0.26.3_Linux_x86_64.tar.gz'
      sha256 '3dcc178d3b85c799cd38ae90247be2703d5c5982eeb733757ce58fb6b504c8e4'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.3/eng_0.26.3_Linux_arm64.tar.gz'
      sha256 '7a5c18739aa917f3d956bdfc15d15134d8a9ed2fa2f83dfc7a3613a436ea4299'
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
