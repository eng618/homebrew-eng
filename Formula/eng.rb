class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.20.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.20.4/eng_0.20.4_Darwin_x86_64.tar.gz'
    sha256 '3c37ca5add46a50f8f8a0d9c983eec72c07e5f202125be98a85b8c9ac5357bd0'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.20.4/eng_0.20.4_Darwin_arm64.tar.gz'
    sha256 'af9b68c786e4bab0522a05db79b27e83b538e12de187c7f3682a874c427c602a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.20.4/eng_0.20.4_Linux_x86_64.tar.gz'
      sha256 '85f98c3f4fabb4ff0881007035ec2d8e5f9262f40d716c773dfe4b780a3130ae'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.20.4/eng_0.20.4_Linux_arm64.tar.gz'
      sha256 'aeeaf4fcc19aa6dca5420b3cd88f7d387dab6e4c954a073cc25130b63ab3b794'
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
