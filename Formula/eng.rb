class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.5/eng_0.25.5_Darwin_x86_64.tar.gz'
    sha256 '1714fd2f25a09b109c30fce6673802f8d00cf8fb934c2d3169f16704e78cb800'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.5/eng_0.25.5_Darwin_arm64.tar.gz'
    sha256 '487a2d169569af0f6bb70a927147a6d33c54c6dec3059b6e0e238b1d5158a647'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.5/eng_0.25.5_Linux_x86_64.tar.gz'
      sha256 'baf9daae9645363376f7ca1738bcd918aa4c4133c40b8dd78e7d29cdcc649a17'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.5/eng_0.25.5_Linux_arm64.tar.gz'
      sha256 'b9712d24e403a5416047faa8db61bc486d4a78bb52d4a47852a368bd20ef3127'
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
