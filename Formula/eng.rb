class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.3/eng_0.28.3_Darwin_x86_64.tar.gz'
    sha256 '09fe00ecc2d13cc152b591c1c1c3dfe41f436432425de5efa68699fed5200376'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.3/eng_0.28.3_Darwin_arm64.tar.gz'
    sha256 'f1338428bc0b965eb782b1f3684c9bc9446048dac868e1c21fba77ff7332a4d4'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.3/eng_0.28.3_Linux_x86_64.tar.gz'
      sha256 'af9a5f62a9ff6870896d3429d17c891ba6d9de15ccc3f15ddc2cb3edc393f8dc'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.3/eng_0.28.3_Linux_arm64.tar.gz'
      sha256 '662e16e66d714dd53cb1a9b10cd9ead5c647ce04910b0ec707ac0e3e7cf72e7b'
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
