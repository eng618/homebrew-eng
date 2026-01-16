class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.31.2'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.31.2/eng_0.31.2_Darwin_x86_64.tar.gz'
    sha256 '3900b7adf28dbc3763f42fd89cd6edfe9173d5bee81e950794b723817cc7ecbd'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.31.2/eng_0.31.2_Darwin_arm64.tar.gz'
    sha256 '7f988e73412647c7a780c48bcfa7bbbd64f7333012e2908cc03716c4493e50c0'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.31.2/eng_0.31.2_Linux_x86_64.tar.gz'
      sha256 'dddad38ba13278d4714d1d841320236ae32704966cda24d91d4b8593a2f5cd26'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.31.2/eng_0.31.2_Linux_arm64.tar.gz'
      sha256 '9d87d36e2354b131d80655c488ffb15cfcf870b7b5bd9a22828bde844f69eac0'
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
