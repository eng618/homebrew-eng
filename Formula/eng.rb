class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.21.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.21.2/eng_0.21.2_Darwin_x86_64.tar.gz'
    sha256 'b0dbbb18aa3df6e4a5fa1b6f367dac9c67b94e052fe7f0928b84a6ea31843528'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.21.2/eng_0.21.2_Darwin_arm64.tar.gz'
    sha256 'a335bf48d0020a8cfed4a775a561cc2f9772c9798278226e637996ce25da5ec2'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.21.2/eng_0.21.2_Linux_x86_64.tar.gz'
      sha256 '8891bb2b83e6b3977993f0fce7f2783c7a434e701df8aa73dfa16d1782c80449'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.21.2/eng_0.21.2_Linux_arm64.tar.gz'
      sha256 '5f15f219b1322ac1f70283f1a6e434c10c613b075761b870b6696a301e00be2f'
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
