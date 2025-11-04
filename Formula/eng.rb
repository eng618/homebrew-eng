class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.0/eng_0.26.0_Darwin_x86_64.tar.gz'
    sha256 '93bc453030fdb62be15a41b17e3adb95cc4ef691da335216158c789d923c049b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.0/eng_0.26.0_Darwin_arm64.tar.gz'
    sha256 '0a211f4875c8a46e9a38b1561b5fdba6fd288b271976c02b00724410e45499a1'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.0/eng_0.26.0_Linux_x86_64.tar.gz'
      sha256 '9dc0f971b2f85fa40e515a0ee4fa75b3406e97ea1e9733221067dbbd5e5e6b6e'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.0/eng_0.26.0_Linux_arm64.tar.gz'
      sha256 '803dce42b03c1a0d6be85d9f17cf11c9f2268965304e25638149cfbe57c4a5c3'
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
