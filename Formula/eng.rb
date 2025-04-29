class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.15'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.15/eng_0.17.15_Darwin_x86_64.tar.gz'
    sha256 '6cb09839ccad03e7952cb604f3bc99446ac492cd08733f43198886efcf48b6a1'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.15/eng_0.17.15_Darwin_arm64.tar.gz'
    sha256 '2745bdda8ad04c0ed75422466b57d440378fb233cf336a2555c374aa8ad01d4c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.15/eng_0.17.15_Linux_x86_64.tar.gz'
      sha256 '068fec2e77f6bf195e6789fad92bd81bebb3ddb408eb3f7b256fe0b8e6613106'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.15/eng_0.17.15_Linux_arm64.tar.gz'
      sha256 'ff5287adab9dfbb763895d115b749fc8b306e65d2226d343a9df12bab722c5b5'
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
