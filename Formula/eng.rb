class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.7'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.7/eng_0.25.7_Darwin_x86_64.tar.gz'
    sha256 '438fbd8f29d302c9d6e65611eb6cb20d91f4945de59a8fe5fd54159700bfb7c5'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.7/eng_0.25.7_Darwin_arm64.tar.gz'
    sha256 'b56b9a9bed9b04b2a44f988a5fb247afa9342bb09100065b4915b41435b2f123'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.7/eng_0.25.7_Linux_x86_64.tar.gz'
      sha256 'c3c1a2033721983af83474b3f1c35fec44a1f89020f43d348cf8801a7cd81d3a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.7/eng_0.25.7_Linux_arm64.tar.gz'
      sha256 '36044cd506a2b2e1f841203a03fbdcd18b90dac9c8ad5782f140c45f616401da'
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
