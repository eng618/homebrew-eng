class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.11.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.11.2/eng_1.11.2_Darwin_x86_64.tar.gz'
    sha256 '4759aeade913e57e7eec7f56cd1ea7e961daa6a0a6fab42ffaa543613beeba94'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.11.2/eng_1.11.2_Darwin_arm64.tar.gz'
    sha256 'c2924dec3db1ccb19245f0ed4a7c1e5b7a56ad36ee298a1d274a62f1815bed8d'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.11.2/eng_1.11.2_Linux_x86_64.tar.gz'
      sha256 '024ca588effb4b1448cbdd444a8dea343cc350d19aaffb7308971db477ba3703'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.11.2/eng_1.11.2_Linux_arm64.tar.gz'
      sha256 '323c9c0d891f55b66b34f2124cea944671971dacef0e6d1dc05754a30dda868e'
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
