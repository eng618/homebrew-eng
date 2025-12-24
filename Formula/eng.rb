class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.7'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.7/eng_0.29.7_Darwin_x86_64.tar.gz'
    sha256 'c9c44d53e23de1e243ce6d113f5fff424f56cedbae0a82a04bdf90173f8ea567'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.7/eng_0.29.7_Darwin_arm64.tar.gz'
    sha256 '4f358054ad52aa4eac6833ee7c2cc0c0bd78c8dda6762569787be7ef1d82f1c1'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.7/eng_0.29.7_Linux_x86_64.tar.gz'
      sha256 '582e1ceb00428feacf3235a763a6eb535ebcacfa4010275788b3103993f331a7'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.7/eng_0.29.7_Linux_arm64.tar.gz'
      sha256 '3bf3025a5bbc965e04efb6413d21ff9d5d600a29500385fe67a18a4fe634f232'
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
