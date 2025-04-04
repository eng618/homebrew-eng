class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.16.14/eng_Darwin_x86_64.tar.gz'
    sha256 'c1c3f52d1532c511a2fb0e8ddea54898ee6b221a515ed14a0469f0bb2fc872b3'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.16.14/eng_Darwin_arm64.tar.gz'
    sha256 '965590a8fab50241bfd0cb910374a72bc21e7753929005971d39ab593da3a866'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.16.14/eng_Linux_x86_64.tar.gz'
      sha256 '63df2592aced1858457a07088d6e1499abc463fe1296a09f0974ac28a67aaa28'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.16.14/eng_Linux_arm64.tar.gz'
      sha256 '16e17205bea03bd2e07c683a85fb81b2e452f79077719231e88e2321739b8e7e'
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
    system "#{bin}/eng", '--version'
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
