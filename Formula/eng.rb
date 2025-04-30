class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.19.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.19.5/eng_0.19.5_Darwin_x86_64.tar.gz'
    sha256 'bbb235e869bd43d2f1f84e3fb2381032c0fb2eae55ac948137f5e3f420f0c914'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.19.5/eng_0.19.5_Darwin_arm64.tar.gz'
    sha256 '6b2b0127ed8b53f5d96f343cddbdfc9b7530c9fff327d80563e7bea074bebd4b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.19.5/eng_0.19.5_Linux_x86_64.tar.gz'
      sha256 '5491c6503d17934a5ec00c508f39f46968ca1981deca285614e980a7b03a396b'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.19.5/eng_0.19.5_Linux_arm64.tar.gz'
      sha256 '716eb6bf9e05058e50816fe36f4e4e756c60cd0a079b7b04a096e0db1d4cd254'
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
