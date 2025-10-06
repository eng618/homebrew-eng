class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.8'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.8/eng_0.25.8_Darwin_x86_64.tar.gz'
    sha256 '0c3ce77508e9e5956d3cde54d2bd24317a0ab72adc5a3bf2b75e362f15b3726e'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.8/eng_0.25.8_Darwin_arm64.tar.gz'
    sha256 '9bddc24da50aef328eac1efd292c87dec4405bd56e74c195f481d05824ef0b22'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.8/eng_0.25.8_Linux_x86_64.tar.gz'
      sha256 '00486a4dfbbc08c0d40919ad002344cb278acdca8880e19fd7372dfa6b6c75d3'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.8/eng_0.25.8_Linux_arm64.tar.gz'
      sha256 '3025c5cf2184fc7d57df1bd350a542702a7de773de5ba1966a0a638cab2ad87c'
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
