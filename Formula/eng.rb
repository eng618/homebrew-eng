class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.27.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.27.0/eng_1.27.0_Darwin_x86_64.tar.gz'
    sha256 '7065c29096778e6f3e416995407e352e0b428d6584849bd4e7802efa3aa627ec'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.27.0/eng_1.27.0_Darwin_arm64.tar.gz'
    sha256 '7ad32fd739d7a0d02c20afdc5860f8cda6d36461edbced2329ccdcffdcea31e9'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.27.0/eng_1.27.0_Linux_x86_64.tar.gz'
      sha256 '5de3007592a6f87f255e2ee39bf8a36e617d9bda4ccb8ddecf774bee2a60ba27'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.27.0/eng_1.27.0_Linux_arm64.tar.gz'
      sha256 '9da36c53ab7376429d2559cafc4ce09fdea0c323cbb7b1484d639ad95946dcef'
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
