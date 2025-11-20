class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.6'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.6/eng_0.26.6_Darwin_x86_64.tar.gz'
    sha256 'b87095b6711c8122a771d52e1908666ac65f847db97b54b3526d943780d4b436'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.6/eng_0.26.6_Darwin_arm64.tar.gz'
    sha256 'b9cdbe8bfa401777ccf1b06f095bc1febf2c53d93b9d77735fe08ea53d0c064f'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.6/eng_0.26.6_Linux_x86_64.tar.gz'
      sha256 'b9ce65889504f83fbecccf8c6d966d3f663ec4a619a5162c7b882d4887dfb604'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.6/eng_0.26.6_Linux_arm64.tar.gz'
      sha256 'f0e9e78b7259a5bcc0d934b9af550c2ed60faf54307ab6c9e496cfd2ba344bbd'
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
