class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.4/eng_0.26.4_Darwin_x86_64.tar.gz'
    sha256 'e67d33bae62db91f14578264c5dc606a29ce6d7a4f90b31792e0742dde2139d6'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.4/eng_0.26.4_Darwin_arm64.tar.gz'
    sha256 '7dc1bd03c6031f3cc5d9914d3cb624294fad7b410e3ee1012c4155c90e8c5cd2'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.4/eng_0.26.4_Linux_x86_64.tar.gz'
      sha256 '8ce118de3edab1deebb7e3da702c00b51bc58406dff933016ec8529277efd5c4'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.4/eng_0.26.4_Linux_arm64.tar.gz'
      sha256 'af6324c53970217d957d3433a932320ca54270117878286c42e6adc66b494998'
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
