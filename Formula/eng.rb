class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.9'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.9/eng_0.17.9_Darwin_x86_64.tar.gz'
    sha256 '3c848d17595a5ed2dbf156b427e7c6eebdcf37377098b979ef68614b780ee404'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.9/eng_0.17.9_Darwin_arm64.tar.gz'
    sha256 'e794a156e3f8beaba4a09da974dea2664bc5527694b72e4391b7e89e79bbdadf'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.9/eng_0.17.9_Linux_x86_64.tar.gz'
      sha256 '8bd2ef0eea3157dbae12e8d80954cc9db6cc7b5b78262a0fdbacc69a8eab75ba'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.9/eng_0.17.9_Linux_arm64.tar.gz'
      sha256 '62eaf6aabef4ed413cac7e36bfd7a2cce4a8d4c77a11c9756e06d1de4d4417c2'
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
