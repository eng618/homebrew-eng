class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.3'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.3/eng_0.29.3_Darwin_x86_64.tar.gz'
    sha256 '19ce774e2d911f72de4ad17fab6febcb30e9367faf636f32ad07849b80244b8a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.3/eng_0.29.3_Darwin_arm64.tar.gz'
    sha256 '9730856c67cba72dc7f249c462ca802f0ce11a561e120f3b08e75b5d1e81059a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.3/eng_0.29.3_Linux_x86_64.tar.gz'
      sha256 '7a60d90cded99cacffa18e376e7c23901bf06a8f52095b0983c7ab9898338210'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.3/eng_0.29.3_Linux_arm64.tar.gz'
      sha256 'ded9c5a0e1872078253134ad4eb7246f8ef12bedaa2976b767200d09c4d615b1'
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
