class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.26.1'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.26.1/eng_0.26.1_Darwin_x86_64.tar.gz'
    sha256 'bcb7b03fa5a2ea7b79aac21bfd76cded947c25234b5121e64a7bfbcd8ab2c044'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.26.1/eng_0.26.1_Darwin_arm64.tar.gz'
    sha256 'a220b63195c494705d1c6ebac8d2766504fe19574695a4943d63b721d05d7128'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.26.1/eng_0.26.1_Linux_x86_64.tar.gz'
      sha256 'a67313618963804f12b591efe85c8146eac331f03ce7200ae6fc83f7add88e22'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.26.1/eng_0.26.1_Linux_arm64.tar.gz'
      sha256 'b747342d29607a6744c0bf49ae71883f359f41f46b0bdd42ccd8bcc5d10a8551'
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
