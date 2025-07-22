class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.22.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.22.1/eng_0.22.1_Darwin_x86_64.tar.gz'
    sha256 '4384318d02f65ced21bfbeec7548ef48f4067eff645876ff9dee9e32b386489a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.22.1/eng_0.22.1_Darwin_arm64.tar.gz'
    sha256 '675d0ee105d0e92157b170915a11dad57306f29b9729e8ac95164e56b68e6c4c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.22.1/eng_0.22.1_Linux_x86_64.tar.gz'
      sha256 '5340dba534f5eb9eb8f8c54a5e87c503fcf1e3d65d41c021003c3b5713f47f55'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.22.1/eng_0.22.1_Linux_arm64.tar.gz'
      sha256 'ef1dbd49939f20ddf2441743b4a8cd7c1876d622cfe135273d7f1721ac817d14'
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
