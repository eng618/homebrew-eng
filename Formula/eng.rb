class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.18.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.18.2/eng_0.18.2_Darwin_x86_64.tar.gz'
    sha256 '55e23598e1fea176c3dd4a6a371c97fb8b44b12a2d754ff5ecdb769964c3780a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.18.2/eng_0.18.2_Darwin_arm64.tar.gz'
    sha256 '2ee7258713374e83eb23e4f696c8c7b049eee7962e430dead280130fc48a84eb'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.18.2/eng_0.18.2_Linux_x86_64.tar.gz'
      sha256 'f68e231217aec05c27d9691828629ff0542af13c9117d2c77ee64d2c0971c1b5'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.18.2/eng_0.18.2_Linux_arm64.tar.gz'
      sha256 'db41b070a6e4a23d89f30c317c47a57f095bde07205dfed004fe97bdb3edb76c'
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
