class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.7'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.7/eng_0.19.7_Darwin_x86_64.tar.gz'
    sha256 'a5348ea6292abb03f9611a15f5be29005c835bfdab35e77308a0b6db3f9121b3'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.7/eng_0.19.7_Darwin_arm64.tar.gz'
    sha256 '595caace1495e19e471635a51b37a3634830a387d4f3ce7eb78dec2ca8c632f8'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.7/eng_0.19.7_Linux_x86_64.tar.gz'
      sha256 '29a20f7dd59780d75bc3c69ca2c2221cd8a3d8799a22ec2413c2bdaaed1e7523'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.7/eng_0.19.7_Linux_arm64.tar.gz'
      sha256 'b32d2c3d8a08624b4731b47e063906420a26623892aa1024c9973cc9683bdcc8'
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
