class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.8'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.8/eng_0.28.8_Darwin_x86_64.tar.gz'
    sha256 'd3e1c6895fd0edaa2fbe7860221f8d56873b4b35e0367d00aba2e5e3a76d82f4'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.8/eng_0.28.8_Darwin_arm64.tar.gz'
    sha256 '8d4db344cefa1178fbb39b86b5c390be0f72ebeea5afbae3b875d22ee5c96ea5'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.8/eng_0.28.8_Linux_x86_64.tar.gz'
      sha256 '0bdc12e676df1ba88eaf62c00fa11a4611ab20eab62df2900a4cec2a9bfa14e5'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.8/eng_0.28.8_Linux_arm64.tar.gz'
      sha256 '26c3658d0523418956d2742bf3795490fbd8be32e649ad61fab24d2f6bc381c0'
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
