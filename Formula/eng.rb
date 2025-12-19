class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.1/eng_0.29.1_Darwin_x86_64.tar.gz'
    sha256 '1e57152ce422836ae3916a9e62f8ba134087caa98ca9d26b4be49f48bad123a2'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.1/eng_0.29.1_Darwin_arm64.tar.gz'
    sha256 '6a742269d92eb21b0b904d7dadcc2fc5e85e6fc57eb8f68f197a1d98a16b6dc8'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.1/eng_0.29.1_Linux_x86_64.tar.gz'
      sha256 '242271b1b2abd156707d30063e8ab454fc5c9d39a073e8f072d0e612115b0017'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.1/eng_0.29.1_Linux_arm64.tar.gz'
      sha256 '8878c1b57e4aae8435a7735f973b948eab13a0c207c540d7ccf1c4bfc2224495'
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
