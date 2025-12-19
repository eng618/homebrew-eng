class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.2/eng_0.29.2_Darwin_x86_64.tar.gz'
    sha256 'a11ba3ea446f0c712a5ab5169f8057d8e93a8bd6bf06c457e3be6142af950723'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.2/eng_0.29.2_Darwin_arm64.tar.gz'
    sha256 '92f4adf162e7fc572d6f9da7e6d01a42bc05820079dd8c5b8df6dfc760e8d072'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.2/eng_0.29.2_Linux_x86_64.tar.gz'
      sha256 '8fe3c93eb418e6792e75dd6c8882ed35e009b85134b227a2a17d2c07e910cd0a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.2/eng_0.29.2_Linux_arm64.tar.gz'
      sha256 'c47223f44cd1a853a7e0ba139bfbf97d7c8969e796b5d97519c3ca9ecb3ade12'
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
