class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.5.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.5.0/eng_1.5.0_Darwin_x86_64.tar.gz'
    sha256 'b5bb8da66b9cee53590e5895ccd7eead6a1c2b99b25b080bf4e85b659be3a617'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.5.0/eng_1.5.0_Darwin_arm64.tar.gz'
    sha256 '12d0ab3f3e474afd725457ea871951af8bdbfce4d8eda7b2947853b0340bacdf'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.5.0/eng_1.5.0_Linux_x86_64.tar.gz'
      sha256 'f5c2b1b8786a8c1541d47d70b0c1746dcbeae8dfbc6228dc3bf1829a6b4b7eb2'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.5.0/eng_1.5.0_Linux_arm64.tar.gz'
      sha256 '88d6bc54e08917e76c91b4133ab0bef141dcf37e9c0c9c1d7c500197ae9e0c9c'
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
