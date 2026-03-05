class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.8.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.8.2/eng_1.8.2_Darwin_x86_64.tar.gz'
    sha256 '10f1735dd4a3831aa9ebd8c402c43e7bc7f70745d49fe626aecd0f93ea9d4303'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.8.2/eng_1.8.2_Darwin_arm64.tar.gz'
    sha256 '614bbd6ae837fd7a50c6bc72fb014c025505e189d06331254399a8228a89ec23'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.8.2/eng_1.8.2_Linux_x86_64.tar.gz'
      sha256 '1aad894b37ec0f58138411f7472f812cbb9efacdb571f0166adcb0e882ca462a'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.8.2/eng_1.8.2_Linux_arm64.tar.gz'
      sha256 '794866b774374627b12c610c5f99790c184e94b920b7bd098e9df71562d5b016'
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
