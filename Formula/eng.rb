class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.2/eng_0.19.2_Darwin_x86_64.tar.gz'
    sha256 '1890acc87b587b73e0c06886185f814ecf8904c8c97c8d428356a6d22cb642fa'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.2/eng_0.19.2_Darwin_arm64.tar.gz'
    sha256 'ebc51be91368f8f3eec219171487e9ac8dfbd6b94ddbf2befbfe1f42e498b9fa'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.2/eng_0.19.2_Linux_x86_64.tar.gz'
      sha256 '30cfd74adbf374011a0469b518a87a1d6cf04150eaa725d1d473bdc3a072b946'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.2/eng_0.19.2_Linux_arm64.tar.gz'
      sha256 'bd58f7465f40fc966a12dbeaaa4f09373c539b5f571ee39eca7d2a7c7fd7c9a9'
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
