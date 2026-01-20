class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.2.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.2.0/eng_1.2.0_Darwin_x86_64.tar.gz'
    sha256 'fe241e7f7dddb570360a9a0635996634b23965437e7feeb04b25870c9128cb10'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.2.0/eng_1.2.0_Darwin_arm64.tar.gz'
    sha256 '8b7e8b97eb1ec350fd735d93fab27c9215687f8ac24aa4e75ea8354e43dd7caa'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.2.0/eng_1.2.0_Linux_x86_64.tar.gz'
      sha256 'e7856cfb665f37b6e3dadc7c2194b0a172b8d25e5ce0586594be45f1a92edacd'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.2.0/eng_1.2.0_Linux_arm64.tar.gz'
      sha256 'c9619ec550c0c958657b9b42e281f5b12c0024b8d6c28638d00a4b0ad0c0dfc5'
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
