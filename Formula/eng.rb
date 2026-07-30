class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.31.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.31.0/eng_1.31.0_Darwin_x86_64.tar.gz'
    sha256 '61107dcef3d130dca9a4e6802d081071351f854e59e57067e8730cebb6aab7f3'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.31.0/eng_1.31.0_Darwin_arm64.tar.gz'
    sha256 'fa7b36ddc91f915d37dbac420d60a62198edfd91f3f2fbad786a8a78886671b0'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.31.0/eng_1.31.0_Linux_x86_64.tar.gz'
      sha256 '8233e10992523ab45d675d84a797858d54a57b58c9938a3a47014201735c46db'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.31.0/eng_1.31.0_Linux_arm64.tar.gz'
      sha256 'e180595178b1821b6b9001d244926ac5068e51042034d8159e2a9da5590b6a74'
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
