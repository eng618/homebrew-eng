class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.30.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.30.0/eng_0.30.0_Darwin_x86_64.tar.gz'
    sha256 '4e093b91afbac1c9e107801645e653d238d1db59383fc7c4a26ddbe472b69c4b'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.30.0/eng_0.30.0_Darwin_arm64.tar.gz'
    sha256 '2390f525afacdf0c3760ad58cc47b610c95a725093b0c3dc1d4d4e5e2dff2355'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.30.0/eng_0.30.0_Linux_x86_64.tar.gz'
      sha256 'eab9d51a9fe8fd037c8567b43c8b1ae48d93454b59da820b35382e97e42d8132'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.30.0/eng_0.30.0_Linux_arm64.tar.gz'
      sha256 '367ef931c14c0738a5c84b3dac51ec4e65b1fdc91dbaf7b05e6b361075c44ed9'
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
