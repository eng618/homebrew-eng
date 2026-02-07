class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.6.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.6.0/eng_1.6.0_Darwin_x86_64.tar.gz'
    sha256 '571e5dec5061df8e8fa50582c97049a0630ff06e56554de70c14d75e7b4d8829'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.6.0/eng_1.6.0_Darwin_arm64.tar.gz'
    sha256 '6154d973ad93992b46623e132ef9ed445242c7791e1e9b5e237274e8ad330c77'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.6.0/eng_1.6.0_Linux_x86_64.tar.gz'
      sha256 '96fb35be3e9b831550e9995c442e21c34020b5fab92c312b9f9743e3f2849c6d'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.6.0/eng_1.6.0_Linux_arm64.tar.gz'
      sha256 'e346e5640d02df7f0b00c49b3d7f7b4c1af424ab3e869f2eb5afe25bdef7f1e8'
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
