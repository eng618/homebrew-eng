class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.35.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.35.0/eng_1.35.0_Darwin_x86_64.tar.gz'
    sha256 'affce3ddc6dd0fd23d6c2896c126d80da60b3aed30ddcbcc05b48cbd25339912'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.35.0/eng_1.35.0_Darwin_arm64.tar.gz'
    sha256 '7355646b4c3db13b181e555274af39539726dea98df10ef5a4eba265c0daa545'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.35.0/eng_1.35.0_Linux_x86_64.tar.gz'
      sha256 'cb5b0a542f6a7c7e96d8cc63a1313523bf97c8eecd3f128bb48ac44771fcd77a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.35.0/eng_1.35.0_Linux_arm64.tar.gz'
      sha256 'bbbe0e89054e61bf45f0a1ec9997be6e52d23b6143cfaa4e4403a88bc9ba119c'
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
