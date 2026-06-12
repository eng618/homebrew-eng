class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.15.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.15.0/eng_1.15.0_Darwin_x86_64.tar.gz'
    sha256 'b989c4b05d6e953664f9f543b3112a12a519149b4f041e8cf8204c9bd8889781'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.15.0/eng_1.15.0_Darwin_arm64.tar.gz'
    sha256 '7d5ec3599eddeb935797fd34134b5c2cbbd7ed921c958b1c3f25233ab3fdc98c'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.15.0/eng_1.15.0_Linux_x86_64.tar.gz'
      sha256 '1e1ca606652ab6a84e0cfa02028712882b18709542e3c49e81521a89fad94dc4'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.15.0/eng_1.15.0_Linux_arm64.tar.gz'
      sha256 '961908f69a3d40ff627a040f2fbfd4c71a8b02f9af7de6af82df537a836c8583'
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
