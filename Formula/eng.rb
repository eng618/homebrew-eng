class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.16.13/eng_Darwin_x86_64.tar.gz'
    sha256 '4238501b52dc24d3584497c40aeb0794a5e2da281b1048be9f8c6bb5133292b8'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.16.13/eng_Darwin_arm64.tar.gz'
    sha256 '91b2a73e2502303893340dcba4b7acefd87577d5515930119721020b17b5b546'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.16.13/eng_Linux_x86_64.tar.gz'
      sha256 'b5c59b02e90269b2520b5802f4f1e97c414c7c9f95407e7b6cebe2676b515090'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.16.13/eng_Linux_arm64.tar.gz'
      sha256 'ca924e202529b8c53b449e7f525371fbd83a1109d99f66ff2f73cc4bb29d2507'
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
