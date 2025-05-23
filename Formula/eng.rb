class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.20.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.20.3/eng_0.20.3_Darwin_x86_64.tar.gz'
    sha256 '0bfdb02016ba930b391eb7af936786b0da1dd6c83712d0f759b98af150c17bcb'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.20.3/eng_0.20.3_Darwin_arm64.tar.gz'
    sha256 'ed04601307226fef12a458676a9c94d052ab85931b26c77359c8f97bccd97da1'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.20.3/eng_0.20.3_Linux_x86_64.tar.gz'
      sha256 '7516c4a8b98f666e479f0c1f918cfd9ccd459d1331a5caff47cb141c977a037f'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.20.3/eng_0.20.3_Linux_arm64.tar.gz'
      sha256 '478bbda584b056d4056d169375f44abd16fc8ac7528984ba82772632715ed2bd'
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
