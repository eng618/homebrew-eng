class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.2/eng_0.26.2_Darwin_x86_64.tar.gz'
    sha256 '1cb409d8fd393a9395bd80419082807b793bc9fd7d2638b3a23393d66335f714'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.2/eng_0.26.2_Darwin_arm64.tar.gz'
    sha256 'bdfedd550b2c9c90edd5e83ad2c830ce97106653ff96a886df760dc83f055a54'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.2/eng_0.26.2_Linux_x86_64.tar.gz'
      sha256 'badb64fba4bd278cedb1161d1cc9de55073fa395456686eecf98d2f27a751a46'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.2/eng_0.26.2_Linux_arm64.tar.gz'
      sha256 '4d14c49ed6c33c4fd1c026bcd7343acbbd0630240536e4eee1b1094c90ff2451'
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
