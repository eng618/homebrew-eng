class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.31.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.31.1/eng_0.31.1_Darwin_x86_64.tar.gz'
    sha256 '935605c7c3c2fdb120e3605830049de9ebf4fc26aa8b61f22b0ee67405e3b25c'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.31.1/eng_0.31.1_Darwin_arm64.tar.gz'
    sha256 '2b222b1d35c4c3cc3d61e76c260416ae88e22061d10c25b8ead666dbedd7040a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.31.1/eng_0.31.1_Linux_x86_64.tar.gz'
      sha256 'e0bd196531b1ee0ba5ee5eb621b38398cad881991f90cd08ea8cb1b3ac49c00a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.31.1/eng_0.31.1_Linux_arm64.tar.gz'
      sha256 'd2681580400fb4aedc1cac9d7b044ca0e31a6778ba10f1aea9fdf123e6be7f09'
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
