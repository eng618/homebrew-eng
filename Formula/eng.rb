class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.33.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.33.0/eng_1.33.0_Darwin_x86_64.tar.gz'
    sha256 '3f6c35bc58366622ba36fcd5a162502bd929a7b93935e046c1b79942ce16227e'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.33.0/eng_1.33.0_Darwin_arm64.tar.gz'
    sha256 '18a31dae1dc7bc19d16cfc42fa510a7992f4f48bad90fa529ae557818ed28ba1'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.33.0/eng_1.33.0_Linux_x86_64.tar.gz'
      sha256 '77fd815a6c4c0505d596b585d732030e2d9e036b8c20260f7092a98934f528bf'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.33.0/eng_1.33.0_Linux_arm64.tar.gz'
      sha256 '0d0f1be53b34c3e59bf92a7c282bbf7036bf3df3d3051597714d7b415245891c'
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
