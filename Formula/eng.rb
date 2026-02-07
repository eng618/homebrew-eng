class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.7.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.7.0/eng_1.7.0_Darwin_x86_64.tar.gz'
    sha256 '942db87a22f409806a0cdb74fee01313c94b51451ed03088ba2088ae3a8e2cc5'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.7.0/eng_1.7.0_Darwin_arm64.tar.gz'
    sha256 'dcc7c2ece90f961229a5555f74996c675bec79292a100c1033176ed769bb7d46'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.7.0/eng_1.7.0_Linux_x86_64.tar.gz'
      sha256 '0f4f2a4f8d136a3679e637767c21131346cf384332a8d75d3e6114497acc8719'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.7.0/eng_1.7.0_Linux_arm64.tar.gz'
      sha256 '9f96509c75bf14c61d702780bdf363868812f5f8d80b62891802dc3988f45ffd'
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
