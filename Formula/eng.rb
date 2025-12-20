class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.4/eng_0.29.4_Darwin_x86_64.tar.gz'
    sha256 'a437efe559b54fae23ac712ca76156ed1ad25ce00f36536a703eec1b890ebd1a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.4/eng_0.29.4_Darwin_arm64.tar.gz'
    sha256 'b7d60128028396133d643e24889f99991b1cfcfea4fca6612dbd74fe20ba58b4'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.4/eng_0.29.4_Linux_x86_64.tar.gz'
      sha256 '5d9e0ebd5edbacf3983d0bd25dc25a7634fc699bc4cc86af582a4fe0b4fd2b87'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.4/eng_0.29.4_Linux_arm64.tar.gz'
      sha256 'e3404f50d70498164e37f39416b71f6d35a62eebdd3950f071154a9691659b6a'
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
