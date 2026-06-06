class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.13.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.13.0/eng_1.13.0_Darwin_x86_64.tar.gz'
    sha256 'ab40184c93994202a0efeb9da551f146ad797bd94c018fbf1b08ee5def7078ae'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.13.0/eng_1.13.0_Darwin_arm64.tar.gz'
    sha256 'e8cafc127a752bdc5e1f5c1235fabf82f55e9ac5cf91d4e1278017b90c32e3e7'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.13.0/eng_1.13.0_Linux_x86_64.tar.gz'
      sha256 'b62a07b633b65edd9c480b874d2a57d815cedddb2df4d118f54fbbce4336574f'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.13.0/eng_1.13.0_Linux_arm64.tar.gz'
      sha256 '880c796d63566558c64b9229ccfc3a3b44531f2c83a475433335bd9e05edc7de'
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
