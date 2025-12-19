class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.13'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.13/eng_0.28.13_Darwin_x86_64.tar.gz'
    sha256 '7648fb4ba674f5eacb608256b4d01609ca333d5da82cf2d544f1ad662a4f9834'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.13/eng_0.28.13_Darwin_arm64.tar.gz'
    sha256 '2df4b390230b1bde70b59b678b1cae5b18fdf44a6ed73d4936314b420c6e5bff'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.13/eng_0.28.13_Linux_x86_64.tar.gz'
      sha256 '1d2fab31f392d1560647ddda4b2bf56f28fa9c13b250e47fc977f3be16b6e408'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.13/eng_0.28.13_Linux_arm64.tar.gz'
      sha256 'ffbb5542d0c17b37060d23966a46543bf02dd291613489180373bd1dd5ed8bd9'
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
