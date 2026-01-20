class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.1.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.1.1/eng_1.1.1_Darwin_x86_64.tar.gz'
    sha256 'c4d14f8a63c910bf74034c9dfb14b1934dda55a4e9f2ceabd0ac5b35216e6615'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.1.1/eng_1.1.1_Darwin_arm64.tar.gz'
    sha256 '5f30199b54bd363aa61cfa592d17fb73b8a11c68f0113ebb24d3f00285aaa7cc'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.1.1/eng_1.1.1_Linux_x86_64.tar.gz'
      sha256 '37c7a576309f9fe8c7552b998fb5577be90ed1e1b421f59a0f5b715952641fb8'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.1.1/eng_1.1.1_Linux_arm64.tar.gz'
      sha256 '0e1396e9394e713b447295ba7d606232ec6e5000ec78ae0574f60e2faed1dea6'
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
