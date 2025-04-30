class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.6'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.6/eng_0.19.6_Darwin_x86_64.tar.gz'
    sha256 '2dc5927604e19bbe29640fb706dbc0b7d6af3cc2cca8fb415e2bc36a9279889b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.6/eng_0.19.6_Darwin_arm64.tar.gz'
    sha256 '423e23016c6bd71cc9f4f173230f981c78bc98460797ece567f942485dc2f0f7'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.6/eng_0.19.6_Linux_x86_64.tar.gz'
      sha256 '793a6249119ea56fcbb19b2343f9bc3d4cb05add94cb06e4f8817823d7bf4a07'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.6/eng_0.19.6_Linux_arm64.tar.gz'
      sha256 '3f8943c3b81f4a546fe33bb8cea94e7d98cc55fab11cfd438a4d1997d704e901'
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
