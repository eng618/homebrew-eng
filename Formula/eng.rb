class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.22.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.22.0/eng_0.22.0_Darwin_x86_64.tar.gz'
    sha256 'd7ab4a471fb0aa2a6011b473e2157f1a1b7ffbdad1f26bd19174f78619225b1a'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.22.0/eng_0.22.0_Darwin_arm64.tar.gz'
    sha256 '8e5e1a58cc89b4824247534b7423b6eeeca91dcfd6e71e78aec525eb171f41c0'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.22.0/eng_0.22.0_Linux_x86_64.tar.gz'
      sha256 '95fadf32b4d866fce89ba5e811fe8273f4bb372b3e0f8c7fc8fc036e333c0255'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.22.0/eng_0.22.0_Linux_arm64.tar.gz'
      sha256 '3eef9f6f5187df2b44e983f1c89272ea14261158aa31a0eae50fb457417645ab'
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
