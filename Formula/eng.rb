class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.6/eng_0.17.6_Darwin_x86_64.tar.gz'
    sha256 '1582b64594d3d44985e02a9c4dad816f34d4bb2e1a9aadf1aae76993d9ac6803'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.6/eng_0.17.6_Darwin_arm64.tar.gz'
    sha256 '7505c8b26107540a0cfe1918fccc5090cbdde3c650992ff1fdb9a48482c91a2a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.6/eng_0.17.6_Linux_x86_64.tar.gz'
      sha256 'f8fa297861e04a3533011269964db04ab28f720213e6c79aeb5525a7193396d2'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.6/eng_0.17.6_Linux_arm64.tar.gz'
      sha256 '083008e9df8492bb495ffe36342485ca53c22c79109a6418ca196b215c85df46'
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
