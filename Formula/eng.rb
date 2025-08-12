class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.23.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.23.1/eng_0.23.1_Darwin_x86_64.tar.gz'
    sha256 'eb0ea7ab65f25539f0418716f8622660570aaedcfe7fc939d738da6af94ebdcb'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.23.1/eng_0.23.1_Darwin_arm64.tar.gz'
    sha256 '6f59c7cb05910ff66d7d3c600162e14ae70563234061621771ba16f7a58ed9a8'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.23.1/eng_0.23.1_Linux_x86_64.tar.gz'
      sha256 'cffe2c2439620396770cf4b2b4dee47766286ca4fa8b2baabfa7c16870b9676a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.23.1/eng_0.23.1_Linux_arm64.tar.gz'
      sha256 'dcb679578a2bb4d44429f60e47e6b877da81b319248096c7cd6fae2e3d690656'
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
