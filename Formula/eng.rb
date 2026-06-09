class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.14.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.14.0/eng_1.14.0_Darwin_x86_64.tar.gz'
    sha256 '4a9ef53aecff3de0aae2e25542bbb027b44276d5911f64011b052091149031ec'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.14.0/eng_1.14.0_Darwin_arm64.tar.gz'
    sha256 '887576855300d0c15109ab30ff6de87f7cf41da0f0bb7211bffe5535c84afe9c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.14.0/eng_1.14.0_Linux_x86_64.tar.gz'
      sha256 '23e53b05b7e414106d143ba38bea45d679f208f86b9a087248f8a6f192acb623'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.14.0/eng_1.14.0_Linux_arm64.tar.gz'
      sha256 '9f77bad4e9dd384b2b3ebf643504326f7a482ea26a75c339d770fc1a8ebf5d4c'
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
