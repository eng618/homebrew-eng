class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.27.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.27.3/eng_0.27.3_Darwin_x86_64.tar.gz'
    sha256 '66357247b55e57298d861a101fce3a51187e61a030b0ef8e9b6dca506c2b8306'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.27.3/eng_0.27.3_Darwin_arm64.tar.gz'
    sha256 'c0ef1e4cf4933ca1c00c2487ed05e793cd118fc291cffca1eeeab0b5d053c512'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.27.3/eng_0.27.3_Linux_x86_64.tar.gz'
      sha256 '472463a4bbcd6f9ef094eed0d4de2108c4d43634039bac50e44160f4f5a51799'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.27.3/eng_0.27.3_Linux_arm64.tar.gz'
      sha256 'ff8962fbd6b3926924a5e0a0009ecfd85999a13655e0aa816bae207ea011e841'
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
