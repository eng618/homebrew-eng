class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.4.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.4.0/eng_1.4.0_Darwin_x86_64.tar.gz'
    sha256 '68af7c0f7a55c84664140eacf2a6fae3f852da19941d78cba883eda28e322eaf'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.4.0/eng_1.4.0_Darwin_arm64.tar.gz'
    sha256 'f370d055fd8db6bd554f448677e84c75067e9a1203465239409f553be618a145'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.4.0/eng_1.4.0_Linux_x86_64.tar.gz'
      sha256 '0ce8086fa64871647919ee2b60457f1ebcd1774976c0c81a8c678518d6e2f4b4'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.4.0/eng_1.4.0_Linux_arm64.tar.gz'
      sha256 '06638210e1cef3cf94fc2eddd9f7e36da024ad6c7c862bb1ed91687b75275b98'
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
