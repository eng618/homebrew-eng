class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.3.6'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.3.6/eng_1.3.6_Darwin_x86_64.tar.gz'
    sha256 'a134c62aff613753005f10ba834ff372134cc411080cb4f10048ad64d91e4b75'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.3.6/eng_1.3.6_Darwin_arm64.tar.gz'
    sha256 'ace100001d400694ec49b1d5ea609e79f07773003df87b5c07e5c2d70eeca208'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.3.6/eng_1.3.6_Linux_x86_64.tar.gz'
      sha256 'b03dee4245c1d9a167a03b889623580f66814541477d43a377db746802776784'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.3.6/eng_1.3.6_Linux_arm64.tar.gz'
      sha256 '9f5154256574b4018c0f370195fa4cb752dbb3677e9985fa1c417156df8cfebe'
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
