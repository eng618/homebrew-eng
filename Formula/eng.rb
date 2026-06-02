class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.12.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.12.0/eng_1.12.0_Darwin_x86_64.tar.gz'
    sha256 'ece3e38eeb1910c5ac5d7d8c93023d2a35765c57c727c816a370d6b5319afda2'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.12.0/eng_1.12.0_Darwin_arm64.tar.gz'
    sha256 'f0f01c5ab094f25a1cc69775144e35585a778bdb628994fc96b9d1fd06e2b5f1'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.12.0/eng_1.12.0_Linux_x86_64.tar.gz'
      sha256 '8d977381cebcfa1b14d1595b67451f72416c5f32f47437ea3dd20e297c10a6a6'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.12.0/eng_1.12.0_Linux_arm64.tar.gz'
      sha256 '1f144dfd8928c3c75179ca127903d55f85e834f8e49ab95bb21cb59d98e6c08d'
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
