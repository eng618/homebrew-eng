class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.3/eng_0.19.3_Darwin_x86_64.tar.gz'
    sha256 'ffa25409236c9406dd7917fac3d1ac2f6bae21dd9103c4026df7274680eabaec'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.3/eng_0.19.3_Darwin_arm64.tar.gz'
    sha256 '4b291a41db026e49d9ad1f343a7e2f74ebca7e8f07f8fa9122627ea85260760b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.3/eng_0.19.3_Linux_x86_64.tar.gz'
      sha256 '35548361af50381fc087fc57803409da230010d335c411bc96658410a2e780fe'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.3/eng_0.19.3_Linux_arm64.tar.gz'
      sha256 '25c787f1526ce6bdf2afc5812c577b324cf52e54dab0d0512fe1b8d341de52cb'
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
