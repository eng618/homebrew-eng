class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.28.6'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.28.6/eng_0.28.6_Darwin_x86_64.tar.gz'
    sha256 'b2edb10a3a112c0e8fb738ef0264dbcddf28af8e9a0787750f02b208d5c5a7ca'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.28.6/eng_0.28.6_Darwin_arm64.tar.gz'
    sha256 '5b9a85e29d02341845a11e3872ea12b6b85c8252f1f1db27d641e2b2f5f94e35'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.28.6/eng_0.28.6_Linux_x86_64.tar.gz'
      sha256 '3ea75080a802c4aab95493313081e0ba02792d6fc4a57e43826328518d1f2853'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.28.6/eng_0.28.6_Linux_arm64.tar.gz'
      sha256 'a16ff73f9d931a6d61bb4f9f1ab38049101147cc405cbdd15aa52ceb9910a253'
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
