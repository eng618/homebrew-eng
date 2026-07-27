class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.25.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.25.0/eng_1.25.0_Darwin_x86_64.tar.gz'
    sha256 '864d60864c2831144221e16099a7c9ed8b21369ec9ce30ae0ab2993cb61d6c1b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.25.0/eng_1.25.0_Darwin_arm64.tar.gz'
    sha256 'ddba98b0e1f3712efed35e64e23e19ae6f0026d0851189e36c6f6d8882e7514c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.25.0/eng_1.25.0_Linux_x86_64.tar.gz'
      sha256 'b8e35a0e11e5a14a55a0c74b5b0adc128ab0928007e9fefa232e8748fb240d23'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.25.0/eng_1.25.0_Linux_arm64.tar.gz'
      sha256 'e3b86bffd4fbc216de2f6d38cedefa9466bd9bf0b994d04ad5da1c1db3f0b744'
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
