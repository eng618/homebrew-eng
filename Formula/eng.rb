class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.24.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.24.1/eng_0.24.1_Darwin_x86_64.tar.gz'
    sha256 '84bc07be577c46eb47433be3c161192208a34569ba062b3a9e36bbf521349d62'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.24.1/eng_0.24.1_Darwin_arm64.tar.gz'
    sha256 '9bce4ca7053573a7123c9b096a0f14738f24b4b903b019d0fed75957ee3d3393'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.24.1/eng_0.24.1_Linux_x86_64.tar.gz'
      sha256 '0420a12e33861ff26c5d6501e2147c76286c677a41c797f8041c15aebfaa8ac4'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.24.1/eng_0.24.1_Linux_arm64.tar.gz'
      sha256 '086457f40ccfd717bca3ad731423b17ac4d8656c6a58b9707032280445e8dfe5'
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
