class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.9.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.9.0/eng_1.9.0_Darwin_x86_64.tar.gz'
    sha256 '6c857f0c415c06019f3eeb45377e4f38cf15bd1e4c764caf0b5b43523ac17a9d'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.9.0/eng_1.9.0_Darwin_arm64.tar.gz'
    sha256 '8e6a692bc35d0e0b0ce865b1c983e94ab9972e337865daca2eeaa7c5a9f80392'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.9.0/eng_1.9.0_Linux_x86_64.tar.gz'
      sha256 'e1f49c3958fa2ac8b64208b57b124dddefd39195d670855887bbfd4fc532507d'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.9.0/eng_1.9.0_Linux_arm64.tar.gz'
      sha256 '935b94691bab2cf080f9c0a4937baa9f12027b1961f8b64156f3e17b09326b53'
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
