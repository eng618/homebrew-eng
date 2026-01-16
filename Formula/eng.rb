class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.31.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.31.0/eng_0.31.0_Darwin_x86_64.tar.gz'
    sha256 '743cf879ef0b3e88ea6f9ea1bc055ca4b03f3a28e2c0b92299b0a4f000257da7'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.31.0/eng_0.31.0_Darwin_arm64.tar.gz'
    sha256 'e6eb69bdc0e7d20182bf0cf778b1a742979c6b2e423d48ade2525d8ba78f97da'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.31.0/eng_0.31.0_Linux_x86_64.tar.gz'
      sha256 '7cfd6720ebdc7817bd6d3e49671ceab8e30adaa877381af105ea825bc739ab65'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.31.0/eng_0.31.0_Linux_arm64.tar.gz'
      sha256 'e11cee83382de960b04ed63b890b4d3160387eb1d2a9a7b0afcb8afc39dacde3'
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
