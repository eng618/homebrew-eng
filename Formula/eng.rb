class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.5/eng_0.17.5_Darwin_x86_64.tar.gz'
    sha256 'b431187937fdb4540bb26c370a4100e8456f8d2be54961675903fbf7c1556040'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.5/eng_0.17.5_Darwin_arm64.tar.gz'
    sha256 'da87602068245d74fc34f98ab3b1b87eb83628ab6378c2c1c4751430479a9e7f'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.5/eng_0.17.5_Linux_x86_64.tar.gz'
      sha256 '71d2eea759e00bc8a59f1867b4e13ebfd20868d8e19d446ddd4a413d8c315231'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.5/eng_0.17.5_Linux_arm64.tar.gz'
      sha256 '02a77833e42e2c2d9bea6c640f754297b35a4b1cfa52fbe9593d896754fe90c4'
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
