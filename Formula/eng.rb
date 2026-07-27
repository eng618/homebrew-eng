class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.22.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.22.0/eng_1.22.0_Darwin_x86_64.tar.gz'
    sha256 'ab2d6ebe3fb73e4cb93343fafafba99f42ccf8a443fa7a89bb28815e12126e4d'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.22.0/eng_1.22.0_Darwin_arm64.tar.gz'
    sha256 'ff648695a5f1cca13a2ed0c5a97ca0447c4b6790c569255c3928b9e37dca4fdd'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.22.0/eng_1.22.0_Linux_x86_64.tar.gz'
      sha256 '0d86896e8b0c9cb2434e7ec212a5e2ca91dd71487e5ddaf89aef556273cba401'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.22.0/eng_1.22.0_Linux_arm64.tar.gz'
      sha256 'e9734983b4e8bf0898aa5d554a73096737e941089bf80ee08b1e640618762aa3'
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
