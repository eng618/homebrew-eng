class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.0/eng_Darwin_x86_64.tar.gz'
    sha256 '2986adab509fce51ac7ed2a3abea927a34f0f0caad57dda52c599176365e4e8d'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.0/eng_Darwin_arm64.tar.gz'
    sha256 'c4f14a2db840b86b23e3bb40f498bfdfec31e6caa56e7130d52a0eb868fc6001'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.0/eng_Linux_x86_64.tar.gz'
      sha256 'b603fae847750d531ab14e09c7600a8cfbf583ab8be84609f8345fffca9d0ab8'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.0/eng_Linux_arm64.tar.gz'
      sha256 'fa7e33e4bf2766928040d8c898d882d46ab6cf2cc730ec3bf7006f97e3a5266f'
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
