class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.16'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.16/eng_0.25.16_Darwin_x86_64.tar.gz'
    sha256 '5df41de9771edda93d5a9d750134376f5115b44e8ade289ba756a65288bf4719'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.16/eng_0.25.16_Darwin_arm64.tar.gz'
    sha256 '3399306e94deced9d1db05ea710a93968c1d4a53726f7e5a7517e14c1d6bf90c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.16/eng_0.25.16_Linux_x86_64.tar.gz'
      sha256 '5cfd495c1251e2825661d59f8d8151569f5fd03eeed42d4dfd7e50a592c67980'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.16/eng_0.25.16_Linux_arm64.tar.gz'
      sha256 'bc4469be7d772f9f20f461a2b5da6dde840256e5e2aa08db7b43d1948b5e7b68'
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
