class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.10'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.10/eng_0.17.10_Darwin_x86_64.tar.gz'
    sha256 'b9729bda9a9b59e596dfb94e3cd3114ad91f569674d80b509028f3bf8a59b4a2'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.10/eng_0.17.10_Darwin_arm64.tar.gz'
    sha256 'dafe34f763aab8f399ba5f11c7a4a5e362aeef7ced26c5c6f8b051bc8e6339d3'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.10/eng_0.17.10_Linux_x86_64.tar.gz'
      sha256 '99e1c2b3e70a406dd0ad1e96c36b348dbbee7c733b3f1cb7f5f2a7a0fe5f3738'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.10/eng_0.17.10_Linux_arm64.tar.gz'
      sha256 '1a69378ed070b1d355b628f4a3b810068bf83620b936ca9ab53359302d82a62d'
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
