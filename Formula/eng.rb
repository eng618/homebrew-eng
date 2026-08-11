class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.37.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.37.0/eng_1.37.0_Darwin_x86_64.tar.gz'
    sha256 '466e3bd699d33a6a171424c79c10f8da322c83641163410ef90088b4a86ad92f'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.37.0/eng_1.37.0_Darwin_arm64.tar.gz'
    sha256 '725126eeeef74602f26c772a0b551e1a70118843e27036c1f79c704a4ce44d4a'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.37.0/eng_1.37.0_Linux_x86_64.tar.gz'
      sha256 '524642d39c2d93005b6c71c365465b1e4305351aea027e64e9759d4ee363ecdb'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.37.0/eng_1.37.0_Linux_arm64.tar.gz'
      sha256 '5a69b3788891409cdcbf4e2eebf0604a19fbfbd3b1a64bd3ab910b112a117093'
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
