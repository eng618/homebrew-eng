class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.8'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.8/eng_0.19.8_Darwin_x86_64.tar.gz'
    sha256 '785297d60bd7bcc23c983c60a9c0e143352c4c26b4d8ae2b81de1a8f73aefcfa'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.8/eng_0.19.8_Darwin_arm64.tar.gz'
    sha256 '7c3b4490b4ef21d877663b8ccdd8e5ba48b4ce4553a8410507ded0748c345260'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.8/eng_0.19.8_Linux_x86_64.tar.gz'
      sha256 '8dff8143307b4a73b4327b2818c2d47bcda511e80d6826a74e3d324a2338d73e'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.8/eng_0.19.8_Linux_arm64.tar.gz'
      sha256 'c2c2a12f97be1467cd8935d6c9ce2ee37b204d6a19a1003a8d4206df81ad0a7e'
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
