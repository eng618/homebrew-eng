class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.1/eng_0.28.1_Darwin_x86_64.tar.gz'
    sha256 'f1b91772d31f1fe31e785d13474e8774e5a56111381b328e09576796a2d062fa'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.1/eng_0.28.1_Darwin_arm64.tar.gz'
    sha256 '934e1655a74268b9f590a92f04225733122b5c4d28f5d867bd79608a9f18268d'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.1/eng_0.28.1_Linux_x86_64.tar.gz'
      sha256 '865296240aceae944b8774264fdf93af603d703ca5ba48013d3508583118a382'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.1/eng_0.28.1_Linux_arm64.tar.gz'
      sha256 '53e1954cf8790b1af82a2adefba9eaacf4a325e06d6ca99ac2920579a206860f'
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
