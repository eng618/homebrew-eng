class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.18.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.18.1/eng_0.18.1_Darwin_x86_64.tar.gz'
    sha256 'aaaa51c3cbe7f22c0178d4f3ab82c4aecaaed75335564baf02b4ee5df2ca7aee'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.18.1/eng_0.18.1_Darwin_arm64.tar.gz'
    sha256 '1c421dd9384698959904ec893505a105d1a53dd35437b37b68299127a39631fd'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.18.1/eng_0.18.1_Linux_x86_64.tar.gz'
      sha256 '40af2549a3bf58a3e3aef0b47387b17e5650134329c58a5e08c09c840354beb8'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.18.1/eng_0.18.1_Linux_arm64.tar.gz'
      sha256 'b7ed602ae7710259d450298185c529c6b0f890bb0955f5d420452801f4bc9b31'
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
