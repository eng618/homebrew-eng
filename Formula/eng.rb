class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.16.12/eng_Darwin_x86_64.tar.gz'
    sha256 'd8aeb4b47c73e91a0a5cdf3a3473b4d894cb0b9d9c7e61dbe49af3c165283baf'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.16.12/eng_Darwin_arm64.tar.gz'
    sha256 '809b84c858c04e35aeedbd3d54e0204ba07158ee70c968342bfaa5327c7bc1dd'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.16.12/eng_Linux_x86_64.tar.gz'
      sha256 'e533dcd15ffb592b9d0596bea901cf46507d7846a302f4d44767398c539a9ed7'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.16.12/eng_Linux_arm64.tar.gz'
      sha256 '4cdea0d72234c9181cff240fa66eb1a32a235ad611ca7450d33504bbe93a78e1'
    end
  end
  license 'MIT'

  def install
    puts "bin: \#{bin}"
    puts "Installing eng to: \#{bin}"
    bin.install 'eng'
    puts "eng installed successfully"
    puts "Permissions of eng: \#{File.stat("\#{bin}/eng").mode.to_s(8)}"
    # Verify the binary is functional before generating completions
    system "\#{bin}/eng", '--version'
    generate_completions
  end

  def generate_completions
    puts "PATH: \#{ENV['PATH']}"
    puts "Running: \#{bin}/eng completion bash"
    (bash_completion/'eng').write Utils.safe_popen_read("\#{bin}/eng", 'completion', 'bash')
    (zsh_completion/'_eng').write Utils.safe_popen_read("\#{bin}/eng", 'completion', 'zsh')
    (fish_completion/'eng.fish').write Utils.safe_popen_read("\#{bin}/eng", 'completion', 'fish')
  end

  test do
    system "\#{bin}/eng", '--help'
  end
end
