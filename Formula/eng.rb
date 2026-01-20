class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.32.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.32.0/eng_0.32.0_Darwin_x86_64.tar.gz'
    sha256 '30d0958985c8e174464266f78ccf16eed21cbcbb4ffcd240beeafac58b74c378'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.32.0/eng_0.32.0_Darwin_arm64.tar.gz'
    sha256 'ce13a3a9b4c7ea528c7167de73e1f55e48ff21d083d4cbe93d5d2299ecc1cf63'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.32.0/eng_0.32.0_Linux_x86_64.tar.gz'
      sha256 'daf3594505bb2432feeafbd426f8b314570924d17ff9dbcc6b971de27e3e72ce'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.32.0/eng_0.32.0_Linux_arm64.tar.gz'
      sha256 'ec0df9412c64f908f804b7db4ee95c32b3296dfeb19123f562d3b4de23d264d2'
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
