class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.12'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.12/eng_0.25.12_Darwin_x86_64.tar.gz'
    sha256 '738489fb17fe4d01b3ec0713d663512e7498754ca75f4df89064425ea6616b3b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.12/eng_0.25.12_Darwin_arm64.tar.gz'
    sha256 '0e1fe4a7010dc6fe490c2a308ce75f884f8dcbb7fd933682384ff684e3f27f3f'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.12/eng_0.25.12_Linux_x86_64.tar.gz'
      sha256 '1634bf7b476934cad7c1de4b1707c6b036ca0aab4238c39102113fa97011bb07'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.12/eng_0.25.12_Linux_arm64.tar.gz'
      sha256 'e53116e55460d435417a52a520c6735a0d7faf8e4c9466028a23879981f0d9e3'
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
