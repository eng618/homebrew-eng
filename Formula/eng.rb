class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.40.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Darwin_x86_64.tar.gz'
    sha256 '6332180d7ae46328d94d2fbe34cceddf3a546f80b2c9db334e3c929fc8d9471c'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Darwin_arm64.tar.gz'
    sha256 '6c66f9c9f7fe8ce74eaba56fbbab087333bccad5623a316fcb4c5456dcc1f9e0'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Linux_x86_64.tar.gz'
      sha256 '1cb8d38648dca33eaed21037ba88d2a7c7979626af706f5f9d4c20e4e0c97f27'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Linux_arm64.tar.gz'
      sha256 '57a50a7815580ca5ba486c0ba26b1d2cfdfda6c1d75ad8042575318f529e7f56'
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
