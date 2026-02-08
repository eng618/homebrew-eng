class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.8.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.8.1/eng_1.8.1_Darwin_x86_64.tar.gz'
    sha256 '88cb8e681f9c2d229a53af45718470df231309ca1fcdddbba75ef1cad32eb281'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.8.1/eng_1.8.1_Darwin_arm64.tar.gz'
    sha256 'f9b2feb0f277f81eee3a234b1a8aa3222a43f1783a2db0637026e04ca2a24b51'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.8.1/eng_1.8.1_Linux_x86_64.tar.gz'
      sha256 'b9593ce3610572d8c634476ceb2f51bdfe247067176dbc1a62386784e4335351'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.8.1/eng_1.8.1_Linux_arm64.tar.gz'
      sha256 '0df6b9db1a61cc786fc98496984b1c7b81060450ada403899bc97e16cc4545ce'
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
