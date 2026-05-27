class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.11.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.11.4/eng_1.11.4_Darwin_x86_64.tar.gz'
    sha256 'b2c680447360dd5daaec367ac8e62938bde4cfb3221b534f4704353b3377a2a2'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.11.4/eng_1.11.4_Darwin_arm64.tar.gz'
    sha256 '8a5a24e4089bacda2468afb628de9f153aee17ff93b9e5e346ebe86a3bca7f6c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.11.4/eng_1.11.4_Linux_x86_64.tar.gz'
      sha256 'ce3c3a32c5da64f484367fee1ad6459a5cce5d75932fcaa090dd4e68c4698435'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.11.4/eng_1.11.4_Linux_arm64.tar.gz'
      sha256 '1ccfbb4bb0fd7256ba5f85394ec1759c026599a713026e87a22be3a8c9036442'
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
