class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.30.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.30.1/eng_0.30.1_Darwin_x86_64.tar.gz'
    sha256 '34ac9a6f8d583633c51f55363b50a2647a9d2bd9553c566b8bc446baa1379885'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.30.1/eng_0.30.1_Darwin_arm64.tar.gz'
    sha256 '169590fc4864ab9a80696583de89f708840080d26a59b36a72827df73bb1901d'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.30.1/eng_0.30.1_Linux_x86_64.tar.gz'
      sha256 'b34686038d531bfa97861161b51a1f934cfd00985f54c8fffabd213239dbb7e7'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.30.1/eng_0.30.1_Linux_arm64.tar.gz'
      sha256 'a58a7faeb6fb9da44124d6544c29a4473215f4ee5f11c89af1b6ba36a264b325'
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
