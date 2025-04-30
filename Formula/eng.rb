class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.18.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.18.3/eng_0.18.3_Darwin_x86_64.tar.gz'
    sha256 '140da1165fb2daaac96b20b95cb08455ed7fdd68e191f34d78a98e999738d5f6'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.18.3/eng_0.18.3_Darwin_arm64.tar.gz'
    sha256 '9c515c09f6ca339859bae6ae8007a8fad1cb0c2814967b450bcee520a5884b1b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.18.3/eng_0.18.3_Linux_x86_64.tar.gz'
      sha256 'e6f20fbfe02d094a9ef486c61dbab6c1d3be0fa2b655b924b162a5d74a5e198b'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.18.3/eng_0.18.3_Linux_arm64.tar.gz'
      sha256 'c7a35bcd1c84dfee227f2185791ed22390f7cb35cf18431f8750b79a60baddc8'
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
