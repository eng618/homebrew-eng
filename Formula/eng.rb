class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.7'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.7/eng_0.17.7_Darwin_x86_64.tar.gz'
    sha256 '37d0a137fd4c1904053e6f65eb64a1fe7cb58a5ba9eaecaa85b546300c7796aa'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.7/eng_0.17.7_Darwin_arm64.tar.gz'
    sha256 '5a26fef3e0030db7e104be5df996e4beafccdf0be38f715c2e1f86020f737d05'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.7/eng_0.17.7_Linux_x86_64.tar.gz'
      sha256 'c0891acfc298c65aaca6b65a9b7efbc0b83649a70cb09aaf7060dac83cce0b49'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.7/eng_0.17.7_Linux_arm64.tar.gz'
      sha256 '503895cba2e70f55a7de335e1210c2bb40bb09b9be80232bd0f53932dfe8bdc0'
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
