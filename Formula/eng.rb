class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.11'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.11/eng_0.25.11_Darwin_x86_64.tar.gz'
    sha256 'af9c47ff98a9105c155258e392fd77e63600c6d454c90277bd3366762f01add1'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.11/eng_0.25.11_Darwin_arm64.tar.gz'
    sha256 'd33ceb28a58175c8856615765894d1d0a6154b0e858f82f9d467e5b1caa57c61'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.11/eng_0.25.11_Linux_x86_64.tar.gz'
      sha256 '77e32d33bbe4c268e2f6b0daec4e8b2da3dafd09fb399bb4bc8bc41256e1f25e'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.11/eng_0.25.11_Linux_arm64.tar.gz'
      sha256 '03b93d7be81c495c1246686ffa281c7e2ad0b64019b3d8fd867ad287674c1b76'
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
