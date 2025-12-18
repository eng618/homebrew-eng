class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.5/eng_0.28.5_Darwin_x86_64.tar.gz'
    sha256 '13befc3d9ae130578cda7e2bf10478b6fcf55e5bf1d77e927db86dda5b93302a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.5/eng_0.28.5_Darwin_arm64.tar.gz'
    sha256 'e3592e51084e6221d0b8a5449c85be88d7819e4f4f02cdba81580112204b25ef'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.5/eng_0.28.5_Linux_x86_64.tar.gz'
      sha256 '974659d187aba21dec1e0fbc5ab0bdc932a7fe08a4f7f3fd049b0ae2f0a54e9a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.5/eng_0.28.5_Linux_arm64.tar.gz'
      sha256 '4aec13ec588057b74deed4e8bd54d43f6dea1b8bee7a5be8f2a6c41097aaba5a'
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
