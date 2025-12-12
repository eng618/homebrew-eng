class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.27.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.27.5/eng_0.27.5_Darwin_x86_64.tar.gz'
    sha256 '790324940aac2acfeafa7c332e9e379ddee96220c2a7e7ddbca99a1d9475d6a4'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.27.5/eng_0.27.5_Darwin_arm64.tar.gz'
    sha256 'fa232129a83ff9db8f25d00a6993221763db0549a122beb678789e9047f9fe90'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.27.5/eng_0.27.5_Linux_x86_64.tar.gz'
      sha256 '27a492f167a054fbbc0b5a159269ce553520740ac011efd0d4a1260259c8d047'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.27.5/eng_0.27.5_Linux_arm64.tar.gz'
      sha256 '0f59aed8ba02d900f29486b2567870a248c4d30ccd2bc1174f4c513439abc8e9'
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
