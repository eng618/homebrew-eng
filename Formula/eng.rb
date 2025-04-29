class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.17.21'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.17.21/eng_0.17.21_Darwin_x86_64.tar.gz'
    sha256 'fe4a7eb2b0b1c5178dc3400d8e4d4d5f4c2ff319b762a1d98d0105c2d9fdc2c5'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.17.21/eng_0.17.21_Darwin_arm64.tar.gz'
    sha256 '056ca8a54d9337c9f54bcb99f2059c55feb6be9900d7a9f2348b5b319bdc728f'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.17.21/eng_0.17.21_Linux_x86_64.tar.gz'
      sha256 'fc43521411fc0539184d3cdd634ea42f6116360bb0d1d8830942cf23da365e2d'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.17.21/eng_0.17.21_Linux_arm64.tar.gz'
      sha256 'f9d994c3cf34951e8e17f808ca699bd5defdb245f8e640aafa460b23c0aa496e'
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
