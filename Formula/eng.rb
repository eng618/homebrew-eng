class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.5/eng_0.26.5_Darwin_x86_64.tar.gz'
    sha256 '07bacde1d214d18bf14a619f93bea8e1fef52429269d77f0faa576c22b0718f8'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.5/eng_0.26.5_Darwin_arm64.tar.gz'
    sha256 '5468b35d585a2d2b0753cfc5a97f0d5fd5cfc8e8ca5158541cda5ae9cb3412e6'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.5/eng_0.26.5_Linux_x86_64.tar.gz'
      sha256 '18c098d81fc09e5f6c1e950443fe6d4fb489e87730c22e747d6dc4b0554f10a5'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.5/eng_0.26.5_Linux_arm64.tar.gz'
      sha256 'e7f53a5ef84dd80648c8c935ea2fa546f65fca6a74e38602330b8da02befa4c2'
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
