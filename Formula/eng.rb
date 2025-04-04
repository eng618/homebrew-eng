class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.16.15/eng_Darwin_x86_64.tar.gz'
    sha256 'b19adb93a0b5af1649774fc9b94a1feb97fd51c3dbe71b1a3bfe427976ec7814'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.16.15/eng_Darwin_arm64.tar.gz'
    sha256 'b7723e3b31c661b4e2ac1ade296af489bf30673a4010801a4c092f3f4a8e0b5f'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.16.15/eng_Linux_x86_64.tar.gz'
      sha256 '6dd5c42971ae911008991824321a5fdd2575b10644c63614b7ea056f42680f9e'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.16.15/eng_Linux_arm64.tar.gz'
      sha256 '0ebfc8921c4e6a174f5cda765a544b904aa817e1a2f68d7cd7e383d67ca470de'
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
