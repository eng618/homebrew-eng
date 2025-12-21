class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.29.5'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.29.5/eng_0.29.5_Darwin_x86_64.tar.gz'
    sha256 '69508bc123345f64179f53d7c674d71e3c26b78101a4f4eca83f0b53ce9c2cd5'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.29.5/eng_0.29.5_Darwin_arm64.tar.gz'
    sha256 '243a865d01b9689e8d4899e1863ad94c4117349a75ca87d8ed88f0b0ee154898'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.29.5/eng_0.29.5_Linux_x86_64.tar.gz'
      sha256 '860ae57b0a8b5e435399eecab468023d78331ad99b4dd136511ca731275734ff'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.29.5/eng_0.29.5_Linux_arm64.tar.gz'
      sha256 '82ecc41d4c05193893df178702380122c043550717263dc8c6992e3c862ee5a6'
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
