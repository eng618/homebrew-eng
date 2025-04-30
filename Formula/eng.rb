class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.18.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.18.4/eng_0.18.4_Darwin_x86_64.tar.gz'
    sha256 'fe8c8f4e46bc2bd74295e5d825bbf3efc79d0fd6e606b80b81f9e5ad225cfa43'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.18.4/eng_0.18.4_Darwin_arm64.tar.gz'
    sha256 'bf31bce46572669bbbdb16455ba40aaceee71746c04ad7e175b2f772c6672b00'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.18.4/eng_0.18.4_Linux_x86_64.tar.gz'
      sha256 'f47f4077b6db79c927d75d04369ebaef81a29136ad350908f1635a14a4b15fdc'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.18.4/eng_0.18.4_Linux_arm64.tar.gz'
      sha256 '1fb6484c75c748844c4f61bf52598e8faebcb7a4fcb6c54fdad580ddf546bab6'
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
