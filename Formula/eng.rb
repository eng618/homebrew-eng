class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.20.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.20.5/eng_0.20.5_Darwin_x86_64.tar.gz'
    sha256 'c72cf77005c0997b5a62f26dc2e56d824f9ea3e414cb6734a6a584753ddddb00'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.20.5/eng_0.20.5_Darwin_arm64.tar.gz'
    sha256 '73116e817959e3e1e1184e3b06b141baa20dcad5e4beed83e83b44109440443d'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.20.5/eng_0.20.5_Linux_x86_64.tar.gz'
      sha256 'ab746cc5971d512c7aeb81b58eac985bc3caf8c5bc5dfa0f9cca279ba2c3aa64'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.20.5/eng_0.20.5_Linux_arm64.tar.gz'
      sha256 'dc11bfa46e79443a050ec0f0a29634c06db6fca283d895cdbeca417701e9a582'
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
