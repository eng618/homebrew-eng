class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.20.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.20.1/eng_0.20.1_Darwin_x86_64.tar.gz'
    sha256 '67aecfd3ad5b0c1e930b5406ea7a9052e886fb73f00c5c3665ffe6de0d31180f'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.20.1/eng_0.20.1_Darwin_arm64.tar.gz'
    sha256 'f06e9e23c7573369e6c54913068d81b2a563d637d641085896f3eff7ab9625ea'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.20.1/eng_0.20.1_Linux_x86_64.tar.gz'
      sha256 'cf4adbcf706982664f86b7f1de5eb365234d8fdc0ebcf2d15dc34c579f5193aa'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.20.1/eng_0.20.1_Linux_arm64.tar.gz'
      sha256 '8b426079395a939a7e6098611e18bbd892b45042873b206aa4e181728429b501'
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
