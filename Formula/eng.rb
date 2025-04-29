class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.18.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.18.0/eng_0.18.0_Darwin_x86_64.tar.gz'
    sha256 'dcb20628c159e59d93143c427b56587796234be7a99df8f08a8d023bdad1578f'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.18.0/eng_0.18.0_Darwin_arm64.tar.gz'
    sha256 '0da87ca68c71a1268c09591c0a4e6b45a3cdbe125f92adc33004743f600f26a2'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.18.0/eng_0.18.0_Linux_x86_64.tar.gz'
      sha256 'f33e86cb3124c2a5369982fc4665c6f1d4e7b53e746c1f264f429ada9e95b93b'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.18.0/eng_0.18.0_Linux_arm64.tar.gz'
      sha256 'e2e3ead16d42d5add21bd2390e71e35c5b05a56cd58e1ad326f57707ed77df36'
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
