class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.20.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.20.0/eng_0.20.0_Darwin_x86_64.tar.gz'
    sha256 'e51712f991a9a24f3dc98573914d6a388295626ed70e71ff3e3929cca1b6e351'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.20.0/eng_0.20.0_Darwin_arm64.tar.gz'
    sha256 '13d04411fdddc3c1d4441edfb35acc50f034626cf9902c7c2f4dbec4976a4ed1'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.20.0/eng_0.20.0_Linux_x86_64.tar.gz'
      sha256 '673768425d58967dd97a3285d7044c3b604de674d7f34935f169780a081eac08'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.20.0/eng_0.20.0_Linux_arm64.tar.gz'
      sha256 'c8da2411258cc992f33ecb3cae15f50226ad7ba34da9404e040383ee65312e81'
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
