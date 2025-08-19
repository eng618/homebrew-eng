class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.4/eng_0.25.4_Darwin_x86_64.tar.gz'
    sha256 'e7a6f86e821484ad4e9d3cb1db98dcebef291d2ea1335035f9bae18f5d7c7e97'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.4/eng_0.25.4_Darwin_arm64.tar.gz'
    sha256 '3220f49584d34e16a63a9f87db92de45f619f05e7a24ee8a36f0439e1a35a97b'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.4/eng_0.25.4_Linux_x86_64.tar.gz'
      sha256 '4f2746deb54a8c9e40d39b5cb1862cff8e1f103bf64cc32a8077a7d67a37ab37'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.4/eng_0.25.4_Linux_arm64.tar.gz'
      sha256 '9e3453b32a0f313d6463c772e5793bdb859d93d686796cf92b46a7eb2cc1c773'
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
