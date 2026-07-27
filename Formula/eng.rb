class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.24.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.24.0/eng_1.24.0_Darwin_x86_64.tar.gz'
    sha256 '08a371411311594492af11600275cf5c4e1977e811569d8ad061d390efeb6e82'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.24.0/eng_1.24.0_Darwin_arm64.tar.gz'
    sha256 '5f1d7a160c7adf0aa34deb02c559fc2aeed6e872125e2f196eb5ae843237e64c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.24.0/eng_1.24.0_Linux_x86_64.tar.gz'
      sha256 '0c6b3a20a0619f22501453297d30fe857915f1956e869b61687909221c39ee01'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.24.0/eng_1.24.0_Linux_arm64.tar.gz'
      sha256 '3909d4ae3f23147194632abc88a1b144b8f13095b30bc877e5e9bba883e6b06b'
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
