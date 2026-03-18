class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.11.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.11.1/eng_1.11.1_Darwin_x86_64.tar.gz'
    sha256 'd5cf351beccdd01677e9400608f39687867d8684a5d840460a1b24fa09eaef0c'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.11.1/eng_1.11.1_Darwin_arm64.tar.gz'
    sha256 '6fdfe4aa94459a75ac3d568107ffd65c45f1af88857b87188ad5878a0ca2e7b5'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.11.1/eng_1.11.1_Linux_x86_64.tar.gz'
      sha256 '427be137648deae57c192d51a476319a8bd1e368266674c8c7ff05caf2ea4993'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.11.1/eng_1.11.1_Linux_arm64.tar.gz'
      sha256 'b359c1e2021a124cc8110f72b7fafb7109572ca38297ec81618ea80f818ad725'
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
