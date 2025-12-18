class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.10'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.10/eng_0.28.10_Darwin_x86_64.tar.gz'
    sha256 '90fd0e1c242d38af43409b28733ed6b1eec07d4cbb34de2cb9376a955e7dd55b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.10/eng_0.28.10_Darwin_arm64.tar.gz'
    sha256 '068813ac54253fa726e0a57130bd5c4f91ac77ba56e01296e0a9ba1882aca09c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.10/eng_0.28.10_Linux_x86_64.tar.gz'
      sha256 '766abd5ad98e0e36337a7644c990fa5bfeb99e12bd2ae7315174bdc56eff0013'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.10/eng_0.28.10_Linux_arm64.tar.gz'
      sha256 'f099f9311c3b535b21c5a059a5bcbf16ecc4babac80945777a8514d7f7c763d9'
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
