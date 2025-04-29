class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.13'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.13/eng_0.17.13_Darwin_x86_64.tar.gz'
    sha256 '107f13bc01db26d99c3cc1b76a31fd91c21b6024f0166d945c70846799eef99f'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.13/eng_0.17.13_Darwin_arm64.tar.gz'
    sha256 '2ed282e93fe34ee3f9823e850440ede39f7b195888d33f1ab0b9b2131ed5786e'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.13/eng_0.17.13_Linux_x86_64.tar.gz'
      sha256 '5fb36f8a59f8e654b2888c003fcc634fbc4426e8f634aaa9332821218b20e4bc'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.13/eng_0.17.13_Linux_arm64.tar.gz'
      sha256 'c8069d7795af6c7870ef358e8cf1d8bcb29731bd07759391b4ce9554f4a5d424'
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
