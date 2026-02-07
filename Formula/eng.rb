class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.6.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.6.1/eng_1.6.1_Darwin_x86_64.tar.gz'
    sha256 '698d54dc365e0e9c21b82eb4ca424eb5680dc264e05aaf7dd59c971c3016e732'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.6.1/eng_1.6.1_Darwin_arm64.tar.gz'
    sha256 '9fac815e26ac06011371205b37be66cbba57eb9702e7c4239b4326b38d559e26'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.6.1/eng_1.6.1_Linux_x86_64.tar.gz'
      sha256 'a126d459174eb66a43f37b04814c8c6a2f7e4beeb4f2f6ba14c5af1bf91e1d01'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.6.1/eng_1.6.1_Linux_arm64.tar.gz'
      sha256 'd212938a159935220e0789735650d67601fcc85fa5dc165cb4040bad28e41d1a'
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
