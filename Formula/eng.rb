class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.20.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.20.2/eng_0.20.2_Darwin_x86_64.tar.gz'
    sha256 'cdcdd9559315108ff8f2b673c4075df121daf650502962c407aa1d666bef1d23'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.20.2/eng_0.20.2_Darwin_arm64.tar.gz'
    sha256 '8ca3d648c919e8da27dd5135b672a4e566497c773cbc927aef37a3bdf977eba8'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.20.2/eng_0.20.2_Linux_x86_64.tar.gz'
      sha256 '95278da14b1f77f557ae917209845676fdf0057b1cbcb2883631b66fe8698d9a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.20.2/eng_0.20.2_Linux_arm64.tar.gz'
      sha256 'aefa19b8e2471bc6a21f3020be7cc43f33b22b797214733a4dd779e6809d0414'
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
