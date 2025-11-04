class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.15'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.15/eng_0.25.15_Darwin_x86_64.tar.gz'
    sha256 'b749033b6522a62fc15ca4c22f30f6a937ec8d7d590231a347ef309023233776'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.15/eng_0.25.15_Darwin_arm64.tar.gz'
    sha256 '1290cdb00698fc02c3674624d3d3aaabf17949b2ee40c6a41dfb5fa7add4444b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.15/eng_0.25.15_Linux_x86_64.tar.gz'
      sha256 '16d3e140f8beec1f1c5eb2b04958e26bf71ff19527b63acaa7331efe5c0d155c'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.15/eng_0.25.15_Linux_arm64.tar.gz'
      sha256 '1376e1a2a4450f120723a9117a89f40724ffccc61a3d5ab2903eb7a780f3b5a4'
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
