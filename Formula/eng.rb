class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.26.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.26.0/eng_1.26.0_Darwin_x86_64.tar.gz'
    sha256 '8f4ce8de13e0befe74dc1a369b563ce2665d989177c2cb8465dab818cc88a582'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.26.0/eng_1.26.0_Darwin_arm64.tar.gz'
    sha256 'ba7a9077326a1c14534d94d1befdc94068f1aa1d1f1de45d476e6778ae8259e5'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.26.0/eng_1.26.0_Linux_x86_64.tar.gz'
      sha256 '68af61a2ea370b0a73a062cdd2be157ccff9a58d67766576e5566ebe47621a01'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.26.0/eng_1.26.0_Linux_arm64.tar.gz'
      sha256 'f1ad56e1926cf1458a80e93c533b1d401fa07d0b5e69683c19696368e60c0863'
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
