class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.3.8'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.3.8/eng_1.3.8_Darwin_x86_64.tar.gz'
    sha256 'bfec6661a75f66ca47c004c51b9dbab935a87a048b6880fd1b6f4569bfae7055'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.3.8/eng_1.3.8_Darwin_arm64.tar.gz'
    sha256 'cd19da431a5158ff0cd6fd35aea54e836d3c4dd731169c53478cde6bb365220c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.3.8/eng_1.3.8_Linux_x86_64.tar.gz'
      sha256 '228c5e7691b90c0ba7f2396ace412dde6c80960e96953f7b005a1b3fb7fc6861'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.3.8/eng_1.3.8_Linux_arm64.tar.gz'
      sha256 '92e432a6ce3a3ba3554b500d2cdf3f68c66e153c7859c76a156bbd966f859556'
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
