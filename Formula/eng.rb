class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.0/eng_0.25.0_Darwin_x86_64.tar.gz'
    sha256 'e2480fb0665dd49b6e11f1bd4ff1960f52408da27b84200ee785c59812aedcbc'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.0/eng_0.25.0_Darwin_arm64.tar.gz'
    sha256 '8c16de7c8374a3c2993c4799f9857885556f58f18a20842a06ca06956e8dc0bf'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.0/eng_0.25.0_Linux_x86_64.tar.gz'
      sha256 '50c946b185b70fba4d99639adba0d6c1294a8e2cad3fc0877b426daf40db284d'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.0/eng_0.25.0_Linux_arm64.tar.gz'
      sha256 '05d033be50122faf0ce5085ac32eca26da65130a27e9ec909201f6f6bc060472'
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
