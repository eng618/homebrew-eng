class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.27.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.27.2/eng_0.27.2_Darwin_x86_64.tar.gz'
    sha256 'fb6cc840e8f472eebbbcb8403e653af82290554ad85b3794229a1f3074829b3a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.27.2/eng_0.27.2_Darwin_arm64.tar.gz'
    sha256 '0c0aa93e76733ba7ee6e3f290a48de57fa1777e7fcb9c56defce8db4b0f665cb'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.27.2/eng_0.27.2_Linux_x86_64.tar.gz'
      sha256 '15e9dfbc012e71100ae46250702fed24c40a330ac98ff049f4306fbe6ac96cc5'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.27.2/eng_0.27.2_Linux_arm64.tar.gz'
      sha256 'bf1bd8a3ecab0f530c7ac135bbdabd155771472643fef3c983057b72be8d0aa8'
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
